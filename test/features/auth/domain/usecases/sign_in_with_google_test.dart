import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music/features/auth/domain/repositories/auth_repository.dart';
import 'package:music/features/auth/domain/usecases/sign_in_with_google.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SignInWithGoogle', () {
    late SignInWithGoogle useCase;
    late MockAuthRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = SignInWithGoogle(mockRepository);
    });

    test('should call repository signInWithGoogle method', () async {
      // Arrange
      when(() => mockRepository.signInWithGoogle()).thenAnswer((_) async {});

      // Act
      await useCase();

      // Assert
      verify(() => mockRepository.signInWithGoogle()).called(1);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      const exception = 'Google sign in failed';
      when(() => mockRepository.signInWithGoogle()).thenThrow(exception);

      // Act & Assert
      expect(() => useCase(), throwsA(exception));
    });
  });
}