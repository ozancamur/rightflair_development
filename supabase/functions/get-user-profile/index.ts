import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.38.4";

// ===========================================
// 📚 TYPE DEFINITIONS
// ===========================================

type PostStatus = "draft" | "published" | "deleted";
type StyleTag =
    | "oversized"
    | "streetwear"
    | "modeling"
    | "casual"
    | "formal"
    | "vintage"
    | "sporty"
    | "bohemian"
    | "y2k"
    | "goth"
    | "minimalist"
    | "techwear"
    | "skater"
    | "retro"
    | "clean_girl";

// Standart API response yapısı
interface ApiResponse<T = unknown> {
    success: boolean;
    message: string;
    data: T | null;
}

// Database'den gelen user yapısı
interface UserProfile {
    profile_photo_url: string | null;
    full_name: string | null;
    username: string;
    followers_count: number;
    following_count: number;
    bio: string | null;
}

// Database'den gelen style tag yapısı
interface UserStyleTagRow {
    style_tag: StyleTag;
}

// Database'den gelen post yapısı
interface PostRow {
    id: string;
    post_image_url: string;
    view_count: number;
}

// Client'a döndürülecek post yapısı
interface PostData {
    id: string;
    imageUrl: string;
    viewCount: number;
}

// Client'a döndürülecek profil yapısı
interface ProfileData {
    profilePhotoUrl: string | null;
    fullName: string | null;
    username: string;
    followersCount: number;
    followingCount: number;
    bio: string | null;
    styleTags: string[];
}

// Client'a döndürülecek posts yapısı
interface PostsData {
    published: PostData[];
    saved: PostData[];
    drafts?: PostData[]; // Sadece kendi profili için
}

// Final response data yapısı
interface ProfileResponseData {
    profile: ProfileData;
    posts: PostsData;
}

// ===========================================
// 📚 YARDIMCI FONKSİYONLAR
// ===========================================

/**
 * JSON response oluşturur
 */
function jsonResponse<T>(data: ApiResponse<T>, status: number = 200): Response {
    return new Response(JSON.stringify(data), {
        status,
        headers: {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
        },
    });
}

/**
 * Hata response'u oluşturur
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
 */
function successResponse<T>(message: string, data: T): Response {
    return jsonResponse<T>(
        {
            success: true,
            message,
            data,
        },
        200
    );
}

/**
 * UUID validasyonu
 */
function isValidUUID(uuid: string): boolean {
    const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
    return uuidRegex.test(uuid);
}

/**
 * Authorization header'dan user ID'yi çıkarır
 */
async function getUserIdFromAuth(authHeader: string | null, supabase: any): Promise<string | null> {
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return null;
    }

    const token = authHeader.substring(7);

    try {
        const { data: { user }, error } = await supabase.auth.getUser(token);

        if (error || !user) {
            return null;
        }

        return user.id;
    } catch {
        return null;
    }
}

/**
 * Post row'ları client formatına çevirir
 */
function formatPosts(posts: PostRow[]): PostData[] {
    return posts.map(post => ({
        id: post.id,
        imageUrl: post.post_image_url,
        viewCount: post.view_count,
    }));
}

// ===========================================
// 📚 ANA FONKSİYON
// ===========================================

serve(async (req: Request): Promise<Response> => {
    // -----------------------------------------
    // CORS Preflight Request Handling
    // -----------------------------------------
    if (req.method === "OPTIONS") {
        return new Response(null, {
            status: 204,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Methods": "GET, OPTIONS",
                "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
            },
        });
    }

    // -----------------------------------------
    // Sadece GET metodunu kabul et
    // -----------------------------------------
    if (req.method !== "GET") {
        return errorResponse("Method not allowed. Use GET.", 405);
    }

    try {
        // -----------------------------------------
        // 1. ENVIRONMENT VARIABLES
        // -----------------------------------------
        const supabaseUrl = Deno.env.get("SUPABASE_URL");
        const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

        if (!supabaseUrl || !supabaseServiceKey) {
            console.error("Missing environment variables");
            return errorResponse("Server configuration error", 500);
        }

        // -----------------------------------------
        // 2. SUPABASE CLIENT OLUŞTUR
        // -----------------------------------------
        const supabase = createClient(supabaseUrl, supabaseServiceKey, {
            auth: {
                autoRefreshToken: false,
                persistSession: false,
            },
        });

        // -----------------------------------------
        // 3. USER ID BELİRLE
        // Query parameter veya auth header'dan
        // -----------------------------------------
        const url = new URL(req.url);
        const queryUserId = url.searchParams.get("user_id");
        const authHeader = req.headers.get("authorization");

        // Auth header'dan gelen kullanıcı (isteği yapan)
        const requesterId = await getUserIdFromAuth(authHeader, supabase);

        // Profili görüntülenecek kullanıcı
        let targetUserId: string;

        if (queryUserId) {
            // Başka kullanıcının profili görüntüleniyor
            targetUserId = queryUserId;
        } else if (requesterId) {
            // Kendi profili görüntüleniyor
            targetUserId = requesterId;
        } else {
            return errorResponse("User ID required. Provide user_id query parameter or valid authorization.", 401);
        }

        // UUID validasyonu
        if (!isValidUUID(targetUserId)) {
            return errorResponse("Invalid user ID format", 400);
        }

        // Kendi profilini mi görüntülüyor?
        const isOwnProfile = requesterId === targetUserId;

        // -----------------------------------------
        // 4. KULLANICI PROFİL BİLGİLERİNİ ÇEK
        // -----------------------------------------
        const { data: userProfile, error: userError } = await supabase
            .from("users")
            .select("profile_photo_url, full_name, username, followers_count, following_count, bio")
            .eq("id", targetUserId)
            .single();

        if (userError || !userProfile) {
            console.error("Error fetching user profile:", userError);
            return errorResponse("User not found", 404);
        }

        // -----------------------------------------
        // 5. STYLE TAG'LERİ ÇEK
        // -----------------------------------------
        const { data: styleTags, error: tagsError } = await supabase
            .from("user_style_tags")
            .select("style_tag")
            .eq("user_id", targetUserId);

        if (tagsError) {
            console.error("Error fetching style tags:", tagsError);
            // Style tags kritik değil, boş array döndür
        }

        const styleTagsArray = styleTags?.map((tag: UserStyleTagRow) => tag.style_tag) || [];

        // -----------------------------------------
        // 6. PUBLISHED POSTLARI ÇEK
        // -----------------------------------------
        const { data: publishedPosts, error: publishedError } = await supabase
            .from("posts")
            .select("id, post_image_url, view_count")
            .eq("user_id", targetUserId)
            .eq("status", "published")
            .order("created_at", { ascending: false });

        if (publishedError) {
            console.error("Error fetching published posts:", publishedError);
            return errorResponse("Error fetching published posts", 500);
        }

        // -----------------------------------------
        // 7. SAVED POSTLARI ÇEK
        // -----------------------------------------
        const { data: savedPosts, error: savedError } = await supabase
            .from("saves")
            .select(`
        posts:post_id (
          id,
          post_image_url,
          view_count
        )
      `)
            .eq("user_id", targetUserId)
            .order("created_at", { ascending: false });

        if (savedError) {
            console.error("Error fetching saved posts:", savedError);
            return errorResponse("Error fetching saved posts", 500);
        }

        // Saved posts'u düzelt (JOIN sonucu nested geliyor)
        const savedPostsFlat = savedPosts
            ?.map((item: any) => item.posts)
            .filter((post: any) => post !== null) || [];

        // -----------------------------------------
        // 8. DRAFT POSTLARI ÇEK (Sadece kendi profili için)
        // -----------------------------------------
        let draftPosts: PostRow[] = [];

        if (isOwnProfile) {
            const { data: drafts, error: draftsError } = await supabase
                .from("posts")
                .select("id, post_image_url, view_count")
                .eq("user_id", targetUserId)
                .eq("status", "draft")
                .order("created_at", { ascending: false });

            if (draftsError) {
                console.error("Error fetching draft posts:", draftsError);
                // Draft'lar kritik değil, boş array döndür
            } else {
                draftPosts = drafts || [];
            }
        }

        // -----------------------------------------
        // 9. RESPONSE OLUŞTUR
        // -----------------------------------------
        const profileData: ProfileData = {
            profilePhotoUrl: userProfile.profile_photo_url,
            fullName: userProfile.full_name,
            username: userProfile.username,
            followersCount: userProfile.followers_count,
            followingCount: userProfile.following_count,
            bio: userProfile.bio,
            styleTags: styleTagsArray,
        };

        const postsData: PostsData = {
            published: formatPosts(publishedPosts || []),
            saved: formatPosts(savedPostsFlat),
        };

        // Draft'ları sadece kendi profili için ekle
        if (isOwnProfile) {
            postsData.drafts = formatPosts(draftPosts);
        }

        const responseData: ProfileResponseData = {
            profile: profileData,
            posts: postsData,
        };

        return successResponse("Profile fetched successfully", responseData);

    } catch (error) {
        console.error("Unexpected error:", error);
        return errorResponse("An unexpected error occurred", 500);
    }
});
