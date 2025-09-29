import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthDataSource {
  FirebaseAuthDataSource(this._auth, this._googleSignIn);
  
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  
  /// Stream of Firebase auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  /// Current Firebase user
  User? get currentUser => _auth.currentUser;
  
  /// Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    
    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }
  
  /// Sign out
  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}