import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/watch_auth_state.dart';
import '../../../../app/di.dart';

class AuthController extends AsyncNotifier<AppUser?> {
  late final SignInWithGoogle _signInWithGoogle;
  late final SignOut _signOut;
  late final WatchAuthState _watchAuthState;
  
  @override
  FutureOr<AppUser?> build() {
    _signInWithGoogle = ref.read(signInWithGoogleProvider);
    _signOut = ref.read(signOutProvider);
    _watchAuthState = ref.read(watchAuthStateProvider);
    
    // Subscribe to auth state changes
    final subscription = _watchAuthState().listen((user) {
      state = AsyncData(user);
    });
    
    // Cleanup subscription when provider is disposed
    ref.onDispose(() {
      subscription.cancel();
    });
    
    return null;
  }
  
  Future<void> signInWithGoogle() async {
    try {
      state = const AsyncLoading();
      await _signInWithGoogle();
      // Auth state will be updated via stream subscription
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
  
  Future<void> signOut() async {
    try {
      await _signOut();
      // Auth state will be updated via stream subscription
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}



final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  () => AuthController(),
);