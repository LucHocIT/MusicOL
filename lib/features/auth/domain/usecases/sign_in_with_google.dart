import '../repositories/auth_repository.dart';

class SignInWithGoogle {
  SignInWithGoogle(this._repository);
  
  final AuthRepository _repository;
  
  Future<void> call() async {
    await _repository.signInWithGoogle();
  }
}