import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Features
import '../features/auth/data/datasources/firebase_auth_data_source.dart';
import '../features/auth/data/datasources/users_doc_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/sign_in_with_google.dart';
import '../features/auth/domain/usecases/sign_out.dart';
import '../features/auth/domain/usecases/watch_auth_state.dart';
import '../features/auth/domain/usecases/get_current_user.dart';

// Firebase instances
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

// Data sources
final firebaseAuthDataSourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(
    ref.read(firebaseAuthProvider),
    ref.read(googleSignInProvider),
  );
});

final usersDocDataSourceProvider = Provider<UsersDocDataSource>((ref) {
  return UsersDocDataSource(ref.read(firestoreProvider));
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(firebaseAuthDataSourceProvider),
    ref.read(usersDocDataSourceProvider),
  );
});

// Use cases
final signInWithGoogleProvider = Provider<SignInWithGoogle>((ref) {
  return SignInWithGoogle(ref.read(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.read(authRepositoryProvider));
});

final watchAuthStateProvider = Provider<WatchAuthState>((ref) {
  return WatchAuthState(ref.read(authRepositoryProvider));
});

final getCurrentUserProvider = Provider<GetCurrentUser>((ref) {
  return GetCurrentUser(ref.read(authRepositoryProvider));
});

// Auth state stream provider
final authStateProvider = StreamProvider<dynamic>((ref) {
  return ref.read(authRepositoryProvider).authState();
});