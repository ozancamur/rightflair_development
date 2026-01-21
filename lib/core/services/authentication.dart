import 'package:google_sign_in/google_sign_in.dart';
import 'package:rightflair/core/services/supabase.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase/exception.dart';

class AuthenticationService extends SupabaseService {
  /// Email ve şifre ile yeni kullanıcı kaydı
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw SupabaseAuthException(e.message);
    } catch (e) {
      throw SupabaseAuthException('Kayıt sırasında bir hata oluştu: $e');
    }
  }

  /// Email ve şifre ile giriş
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw SupabaseAuthException(e.message);
    } catch (e) {
      throw SupabaseAuthException('Giriş sırasında bir hata oluştu: $e');
    }
  }

  /// Google ile giriş
  Future<AuthResponse> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();
      final googleUser = await googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw SupabaseAuthException('Google ID token alınamadı');
      }

      final response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      return response;
    } on AuthException catch (e) {
      throw SupabaseAuthException(e.message);
    } catch (e) {
      throw SupabaseAuthException(
        'Google ile giriş sırasında bir hata oluştu: $e',
      );
    }
  }

  /// Apple ile giriş
  Future<AuthResponse> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        throw SupabaseAuthException('Apple ID token alınamadı');
      }

      final response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
      );

      return response;
    } on SignInWithAppleAuthorizationException catch (e) {
      throw SupabaseAuthException('Apple ile giriş hatası: ${e.message}');
    } on AuthException catch (e) {
      throw SupabaseAuthException(e.message);
    } catch (e) {
      throw SupabaseAuthException(
        'Apple ile giriş sırasında bir hata oluştu: $e',
      );
    }
  }

  /// Şifre sıfırlama maili gönderir
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await client.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw SupabaseAuthException(e.message);
    } catch (e) {
      throw SupabaseAuthException('Şifre sıfırlama maili gönderilemedi: $e');
    }
  }

  /// Kullanıcı çıkışı
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } on AuthException catch (e) {
      throw SupabaseAuthException(e.message);
    } catch (e) {
      throw SupabaseAuthException('Çıkış sırasında bir hata oluştu: $e');
    }
  }
}
