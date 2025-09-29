import '../entities/app_user.dart';

abstract class AuthRepository {
  /// Stream of current auth state
  Stream<AppUser?> authState();
  
  /// Sign in with Google
  Future<void> signInWithGoogle();
  
  /// Sign out
  Future<void> signOut();
  
  /// Get current user
  Future<AppUser?> currentUser();
}