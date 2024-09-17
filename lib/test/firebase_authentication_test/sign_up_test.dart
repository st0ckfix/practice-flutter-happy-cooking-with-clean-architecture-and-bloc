import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../features/authentication/data/datasources/firebase_authentication.dart';

// Mocks
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseUser extends Mock implements User {}

void main() {
  group('SignupUserFirebase', () {
    late SignupUserFirebase signupUserFirebase;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;
    late MockFirebaseUser mockFirebaseUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      signupUserFirebase = SignupUserFirebase(); // Truyền mock vào đây
      mockUserCredential = MockUserCredential();
      mockFirebaseUser = MockFirebaseUser();

      // Cấu hình cho mockUserCredential.user trả về mockFirebaseUser
      when(mockUserCredential.user).thenReturn(mockFirebaseUser);

      // Cấu hình cho mockFirebaseUser.updateDisplayName()
      when(mockFirebaseUser.updateDisplayName(any)).thenAnswer((_) async {});
    });

    test('should return true when signup is successful', () async {
      // Giả lập hành vi khi gọi createUserWithEmailAndPassword
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        ),
      ).thenAnswer(
        (_) async => mockUserCredential,
      );

      final result = await signupUserFirebase.onSignup(
        'test@example.com',
        'password',
        'username',
      );

      expect(result, true);
    });

    test('should return error message when signup fails', () async {
      // Giả lập ngoại lệ khi gọi createUserWithEmailAndPassword
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@example.com',
          password: 'password',
        ),
      ).thenThrow(
        FirebaseAuthException(code: 'email-already-in-use'),
      );

      final result = await signupUserFirebase.onSignup(
        'test@example.com',
        'password',
        'username',
      );

      expect(result, 'email-already-in-use');
    });
  });
}
