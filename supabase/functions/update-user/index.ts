import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.38.4";

// ===========================================
// TYPES
// ===========================================

type UserStatus = "nameless" | "active" | "deleted";

interface UpdateUserRequest {
  username?: string;
  fullName?: string;
  bio?: string;
  profilePhotoUrl?: string;
  fcm?: string;
}

interface ApiResponse<T = unknown> {
  success: boolean;
  message: string;
  data: T | null;
}

interface UserUpdate {
  username?: string;
  full_name?: string | null;
  bio?: string | null;
  profile_photo_url?: string | null;
  fcm?: string | null;
  status?: UserStatus;
  updated_at: string;
  last_active: string;
}

// ===========================================
// HELPERS
// ===========================================

const json = <T>(data: ApiResponse<T>, status = 200) =>
  new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers":
        "authorization, x-client-info, apikey, content-type",
    },
  });

const error = (message: string, status = 400) =>
  json({ success: false, message, data: null }, status);

const success = <T>(message: string, data: T) =>
  json({ success: true, message, data });

function isValidUsername(username: string) {
  if (username.length < 3) return { valid: false, error: "Min 3 characters" };
  if (username.length > 20) return { valid: false, error: "Max 20 characters" };
  if (!/^[a-z0-9_]+$/.test(username))
    return { valid: false, error: "Only a-z, 0-9 and _ allowed" };
  if (/^[0-9]/.test(username))
    return { valid: false, error: "Cannot start with number" };
  if (username.startsWith("_") || username.endsWith("_"))
    return { valid: false, error: "Cannot start/end with _" };
  if (username.includes("__"))
    return { valid: false, error: "No consecutive _" };
  return { valid: true };
}

const RESERVED = new Set([
  "admin","administrator","root","system","support","moderator","mod",
  "official","verified","user","users","guest","anonymous","null","undefined",
  "api","app","apps","backend","frontend","server","client","web","mobile",
  "login","logout","signin","signup","register","profile","account",
  "about","contact","help","terms","privacy","policy",
  "fuck","shit","ass","dick","porn","sex","xxx",
]);

const isReservedUsername = (u: string) => RESERVED.has(u);

// ===========================================
// MAIN
// ===========================================

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 204,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, PUT, PATCH, OPTIONS",
        "Access-Control-Allow-Headers":
          "authorization, x-client-info, apikey, content-type",
      },
    });
  }

  if (!["POST", "PUT", "PATCH"].includes(req.method)) {
    return error("Method not allowed", 405);
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL");
    const anonKey = Deno.env.get("SUPABASE_ANON_KEY");
    const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

    if (!supabaseUrl || !anonKey || !serviceKey) {
      return error("Server configuration error", 500);
    }

    const authHeader = req.headers.get("Authorization");
    if (!authHeader?.startsWith("Bearer ")) {
      return error("Authorization header required", 401);
    }

    const token = authHeader.replace("Bearer ", "");

    // � SERVICE ROLE (RLS BYPASS)
    const db = createClient(supabaseUrl, serviceKey, {
      auth: { persistSession: false },
    });

    // 🔐 Token doğrulama - service role ile getUser
    const { data: { user }, error: authError } = await db.auth.getUser(token);

    if (authError || !user) {
      console.error("Auth error:", authError);
      return error("Invalid or expired token", 401);
    }

    const body: UpdateUserRequest = await req.json();

    if (
      body.username === undefined &&
      body.fullName === undefined &&
      body.bio === undefined &&
      body.profilePhotoUrl === undefined &&
      body.fcm === undefined
    ) {
      return error("At least one field required");
    }

    const { data: currentUser } = await db
      .from("users")
      .select("*")
      .eq("id", user.id)
      .single();

    if (!currentUser) return error("User not found", 404);

    const now = new Date().toISOString();
    const update: UserUpdate = { updated_at: now, last_active: now };

    if (body.username !== undefined) {
      const username = body.username.toLowerCase().trim();

      const v = isValidUsername(username);
      if (!v.valid) return error(v.error!, 400);
      if (isReservedUsername(username))
        return error("Username not allowed", 400);

      if (username !== currentUser.username) {
        const { data: exists } = await db
          .from("users")
          .select("id")
          .eq("username", username)
          .neq("id", user.id)
          .maybeSingle();

        if (exists) return error("Username already taken", 409);

        update.username = username;
        if (currentUser.status === "nameless") update.status = "active";
      }
    }

    if (body.fullName !== undefined)
      update.full_name = body.fullName?.trim() || null;

    if (body.bio !== undefined)
      update.bio = body.bio?.trim() || null;

    if (body.profilePhotoUrl !== undefined)
      update.profile_photo_url = body.profilePhotoUrl || null;

    if (body.fcm !== undefined)
      update.fcm = body.fcm || null;

    const { data, error: updateError } = await db
      .from("users")
      .update(update)
      .eq("id", user.id)
      .select()
      .single();

    if (updateError) {
      return error(updateError.message, 500);
    }

    return success("User updated successfully", { user: data });
  } catch (e) {
    console.error(e);
    return error("Unexpected server error", 500);
  }
});
