import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasources/firebase_auth_data_source.dart';
import '../datasources/users_doc_data_source.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authDataSource, this._usersDataSource);
  
  final FirebaseAuthDataSource _authDataSource;
  final UsersDocDataSource _usersDataSource;
  
  @override
  Stream<AppUser?> authState() {
    return _authDataSource.authStateChanges.asyncMap((user) async {
      if (user == null) return null;
      
      // Get custom claims (roles) from Firebase Auth token
      final idTokenResult = await user.getIdTokenResult();
      final roles = (idTokenResult.claims?['roles'] as List<dynamic>?)
          ?.cast<String>() ?? ['user'];
      
      return AppUser(
        id: user.uid,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        email: user.email,
        roles: roles,
      );
    });
  }
  
  @override
  Future<void> signInWithGoogle() async {
    final userCredential = await _authDataSource.signInWithGoogle();
    final user = userCredential.user;
    
    if (user != null) {
      // Create user document if it's first time login
      await _createUserDocIfNotExists(user);
    }
  }
  
  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }
  
  @override
  Future<AppUser?> currentUser() async {
    final user = _authDataSource.currentUser;
    if (user == null) return null;
    
    // Get custom claims (roles) from Firebase Auth token
    final idTokenResult = await user.getIdTokenResult();
    final roles = (idTokenResult.claims?['roles'] as List<dynamic>?)
        ?.cast<String>() ?? ['user'];
    
    return AppUser(
      id: user.uid,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      email: user.email,
      roles: roles,
    );
  }
  
  /// Create user document in Firestore if it doesn't exist
  Future<void> _createUserDocIfNotExists(User user) async {
    final existingDoc = await _usersDataSource.getUserDoc(user.uid);
    
    if (existingDoc == null) {
      final userData = {
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
        'roles': ['user'], // Default role
        'settings': {
          'language': 'vi',
          'theme': 'system',
          'explicitFilter': false,
          'downloadOverWifiOnly': true,
        },
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      
      await _usersDataSource.setUserDoc(user.uid, userData);
    }
  }
}