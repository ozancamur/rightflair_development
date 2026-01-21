// supabase/functions/check-username/index.ts

// Deno'nun serve fonksiyonunu import ediyoruz
// Bu, HTTP isteklerini dinlememizi sağlar
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

// Supabase client'ı oluşturmak için gerekli import
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// CORS (Cross-Origin Resource Sharing) ayarları
// Bu, farklı domain'lerden gelen isteklere izin verir
const corsHeaders = {
  "Access-Control-Allow-Origin": "*", // Tüm domain'lere izin ver
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

// Response modelimizi standartlaştıran yardımcı fonksiyon
// Her zaman aynı yapıda response döneriz: { success, message, data }
interface ApiResponse<T = unknown> {
  success: boolean;
  message: string;
  data: T | null;
}

function createResponse<T>(
  success: boolean,
  message: string,
  data: T | null,
  status: number = 200
): Response {
  const body: ApiResponse<T> = { success, message, data };
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

// Ana fonksiyon - HTTP isteklerini işler
serve(async (req: Request) => {
  // ------------------------------------
  // 1. CORS Preflight İsteği Kontrolü
  // ------------------------------------
  // Tarayıcılar, gerçek isteği göndermeden önce OPTIONS isteği gönderir
  // Bu "preflight" isteğine izin vermeliyiz
  if (req.method === "OPTIONS") {
    return new Response(null, { headers: corsHeaders });
  }

  // ------------------------------------
  // 2. HTTP Method Kontrolü
  // ------------------------------------
  // Sadece POST isteklerini kabul ediyoruz
  if (req.method !== "POST") {
    return createResponse(
      false,
      "Method not allowed. Use POST.",
      null,
      405 // 405 = Method Not Allowed
    );
  }

  try {
    // ------------------------------------
    // 3. Request Body'yi Parse Et
    // ------------------------------------
    // JSON formatındaki body'yi JavaScript objesine çeviriyoruz
    let body: { username?: string };
    
    try {
      body = await req.json();
    } catch {
      return createResponse(
        false,
        "Invalid JSON body.",
        null,
        400 // 400 = Bad Request
      );
    }

    // ------------------------------------
    // 4. Username Parametresini Doğrula
    // ------------------------------------
    const { username } = body;

    // Username boş mu kontrol et
    if (!username || typeof username !== "string") {
      return createResponse(
        false,
        "Username is required and must be a string.",
        null,
        400
      );
    }

    // Username'i temizle (trim = baştaki ve sondaki boşlukları sil)
    const trimmedUsername = username.trim().toLowerCase();

    // Minimum uzunluk kontrolü
    if (trimmedUsername.length < 3) {
      return createResponse(
        false,
        "Username must be at least 3 characters long.",
        null,
        400
      );
    }

    // Maximum uzunluk kontrolü
    if (trimmedUsername.length > 30) {
      return createResponse(
        false,
        "Username must be at most 30 characters long.",
        null,
        400
      );
    }

    // Username formatı kontrolü (sadece harf, rakam, alt çizgi ve nokta)
    const usernameRegex = /^[a-z0-9._]+$/;
    if (!usernameRegex.test(trimmedUsername)) {
      return createResponse(
        false,
        "Username can only contain lowercase letters, numbers, dots and underscores.",
        null,
        400
      );
    }

    // ------------------------------------
    // 5. Supabase Client Oluştur
    // ------------------------------------
    // Environment variable'lardan Supabase bilgilerini alıyoruz
    // Bu değerler Supabase'de otomatik olarak tanımlıdır
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!supabaseUrl || !supabaseServiceKey) {
      return createResponse(
        false,
        "Server configuration error.",
        null,
        500 // 500 = Internal Server Error
      );
    }

    // Service role key kullanıyoruz çünkü bu fonksiyon public
    // ve RLS (Row Level Security) bypass etmemiz gerekiyor
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    // ------------------------------------
    // 6. Database'de Username Kontrolü
    // ------------------------------------
    // users tablosunda bu username var mı diye sorguluyoruz
    const { data, error } = await supabase
      .from("users")
      .select("id") // Sadece id yeterli, tüm veriyi çekmeye gerek yok
      .eq("username", trimmedUsername) // username = trimmedUsername
      .maybeSingle(); // Tek bir sonuç veya null döner

    // Database hatası kontrolü
    if (error) {
      console.error("Database error:", error);
      return createResponse(
        false,
        "Database error occurred.",
        null,
        500
      );
    }

    // ------------------------------------
    // 7. Sonucu Döndür
    // ------------------------------------
    // data null ise username kullanılmamış demektir (unique)
    // data varsa username zaten alınmış demektir
    const isUnique = data === null;

    return createResponse(
      true,
      isUnique 
        ? "Username is available." 
        : "Username is already taken.",
      { isUnique }
    );

  } catch (error) {
    // ------------------------------------
    // 8. Beklenmeyen Hataları Yakala
    // ------------------------------------
    console.error("Unexpected error:", error);
    return createResponse(
      false,
      "An unexpected error occurred.",
      null,
      500
    );
  }
});