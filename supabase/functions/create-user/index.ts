import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.38.4";

type UserRole = "user" | "brand" | "admin";
type UserStatus = "nameless" | "active" | "deleted";

const DEFAULT_USER_ROLE: UserRole = "user";
const DEFAULT_USER_STATUS: UserStatus = "nameless";

// Kullanıcıdan gelecek request body yapısı
interface CreateUserRequest {
  id: string;
  email: string;
  fullName?: string;
  fcm: string;
}

// Standart API response yapısı
interface ApiResponse<T = unknown> {
  success: boolean;
  message: string;
  data: T | null;
}

// Database'e kaydedilecek kullanıcı yapısı
interface UserInsert {
  id: string;
  email: string;
  username: string;
  full_name: string | null;
  role: UserRole;
  status: UserStatus;
  fcm: string | null;
  followers_count: number;
  following_count: number;
  created_at: string;
  last_active: string;
}

// ===========================================
// 📚 YARDIMCI FONKSİYONLAR
// ===========================================

/**
 * JSON response oluşturur
 * @param data - Response verisi
 * @param status - HTTP status kodu
 */
function jsonResponse<T>(data: ApiResponse<T>, status: number = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      // CORS headers - Farklı domain'lerden erişim için gerekli
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
    },
  });
}

/**
 * Hata response'u oluşturur
 * @param message - Hata mesajı
 * @param status - HTTP status kodu
 */
function errorResponse(message: string, status: number = 400): Response {
  return jsonResponse<null>(
    {
      success: false,
      message,
      data: null,
    },
    status
  );
}

/**
 * Başarılı response oluşturur
 * @param message - Başarı mesajı
 * @param data - Döndürülecek veri
 */
function successResponse<T>(message: string, data: T): Response {
  return jsonResponse<T>(
    {
      success: true,
      message,
      data,
    },
    201 // 201 = Created
  );
}


/**
 * Email validasyonu
 */
function isValidEmail(email: string): boolean {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

/**
 * UUID validasyonu
 */
function isValidUUID(uuid: string): boolean {
  const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  return uuidRegex.test(uuid);
}

/**
 * Geçici username oluşturur
 * Database'de username NOT NULL olduğu için geçici bir değer atıyoruz
 * Kullanıcı daha sonra kendi username'ini seçecek
 */
function generateTempUsername(): string {
  const timestamp = Date.now();
  const random = Math.random().toString(36).substring(2, 8);
  return `user_${timestamp}_${random}`;
}

// ===========================================
// 📚 ANA FONKSİYON
// ===========================================

serve(async (req: Request): Promise<Response> => {
  // -----------------------------------------
  // CORS Preflight Request Handling
  // Tarayıcılar POST isteği öncesi OPTIONS gönderir
  // -----------------------------------------
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 204,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
      },
    });
  }

  // -----------------------------------------
  // Sadece POST metodunu kabul et
  // -----------------------------------------
  if (req.method !== "POST") {
    return errorResponse("Method not allowed. Use POST.", 405);
  }

  try {
    // -----------------------------------------
    // 1. ENVIRONMENT VARIABLES
    // Supabase otomatik olarak bu değişkenleri sağlar
    // -----------------------------------------
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!supabaseUrl || !supabaseServiceKey) {
      console.error("Missing environment variables");
      return errorResponse("Server configuration error", 500);
    }

    // -----------------------------------------
    // 2. SUPABASE CLIENT OLUŞTUR
    // Service role key kullanıyoruz çünkü RLS'i bypass etmemiz gerekiyor
    // -----------------------------------------
    const supabase = createClient(supabaseUrl, supabaseServiceKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false,
      },
    });

    // -----------------------------------------
    // 3. REQUEST BODY'Yİ PARSE ET
    // -----------------------------------------
    let body: CreateUserRequest;

    try {
      body = await req.json();
    } catch {
      return errorResponse("Invalid JSON in request body", 400);
    }

    // -----------------------------------------
    // 4. VALIDASYON
    // -----------------------------------------

    // ID kontrolü
    if (!body.id) {
      return errorResponse("User ID is required", 400);
    }

    if (!isValidUUID(body.id)) {
      return errorResponse("Invalid user ID format. Must be a valid UUID.", 400);
    }

    // Email kontrolü
    if (!body.email) {
      return errorResponse("Email is required", 400);
    }

    if (!isValidEmail(body.email)) {
      return errorResponse("Invalid email format", 400);
    }

    // -----------------------------------------
    // 5. KULLANICI ZATEN VAR MI KONTROL ET
    // -----------------------------------------
    const { data: existingUser, error: checkError } = await supabase
      .from("users")
      .select("id, email")
      .or(`id.eq.${body.id},email.eq.${body.email}`)
      .maybeSingle();

    if (checkError) {
      console.error("Error checking existing user:", checkError);
      return errorResponse("Database error while checking user", 500);
    }

    if (existingUser) {
      if (existingUser.id === body.id) {
        return errorResponse("User with this ID already exists", 409);
      }
      if (existingUser.email === body.email) {
        return errorResponse("User with this email already exists", 409);
      }
    }

    // -----------------------------------------
    // 6. KULLANICIYI OLUŞTUR
    // -----------------------------------------
    const now = new Date().toISOString();

    const newUser: UserInsert = {
      id: body.id,
      email: body.email.toLowerCase().trim(),
      username: generateTempUsername(), // Geçici username
      full_name: body.fullName?.trim() || null,
      role: DEFAULT_USER_ROLE,
      status: DEFAULT_USER_STATUS,
      fcm: body.fcm || null,
      followers_count: 0,
      following_count: 0,
      created_at: now,
      last_active: now,
    };

    const { data: createdUser, error: insertError } = await supabase
      .from("users")
      .insert(newUser)
      .select()
      .single();

    if (insertError) {
      console.error("Error creating user:", insertError);

      // Unique constraint hatası kontrolü
      if (insertError.code === "23505") {
        return errorResponse("User already exists", 409);
      }

      return errorResponse(`Failed to create user: ${insertError.message}`, 500);
    }

    // -----------------------------------------
    // 7. KULLANICI AYARLARINI OLUŞTUR
    // user_settings tablosuna varsayılan değerlerle kayıt
    // -----------------------------------------
    const { error: settingsError } = await supabase
      .from("user_settings")
      .insert({
        user_id: body.id,
        allow_likes_notify: true,
        allow_saves_notify: true,
        allow_milestones_notify: true,
        allow_trending_notify: true,
        allow_follow_notify: true,
      });

    if (settingsError) {
      console.error("Error creating user settings:", settingsError);
      // Settings oluşturulamazsa kullanıcıyı silmiyoruz, sadece log'luyoruz
      // Bu critical değil, sonra oluşturulabilir
    }

    // -----------------------------------------
    // 8. BAŞARILI RESPONSE
    // -----------------------------------------
    return successResponse("User created successfully", {
      id: createdUser.id,
      email: createdUser.email,
      username: createdUser.username,
      fullName: createdUser.full_name,
      role: createdUser.role,
      status: createdUser.status,
      followersCount: createdUser.followers_count,
      followingCount: createdUser.following_count,
      createdAt: createdUser.created_at,
      lastActive: createdUser.last_active,
    });

  } catch (error) {
    // Beklenmeyen hatalar için
    console.error("Unexpected error:", error);
    return errorResponse("An unexpected error occurred", 500);
  }
});

