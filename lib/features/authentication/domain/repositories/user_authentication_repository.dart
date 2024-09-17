import 'package:happy_cooking/core/resource/data_state.dart';

abstract class VertifyWithEmailRepository {
  Future<DataState> vertifyWithEmail(int code, String email);
}

abstract class LoginAsGuestRepository {
  Future<DataState> loginAsGuest();
}

abstract class SignupUserRepository {
  Future<DataState> signupUser(String email, String password, String username);
}

abstract class LogoutUserRepository {
  Future<DataState> logoutUser();
}

abstract class ResetPasswordRepository {
  Future<DataState> resetPassword(String email);
}

abstract class LoginWithEmailRepository {
  Future<DataState> loginWithEmail(String email, String password);
}

abstract class LoginWithGoogleRepository {
  Future<DataState> loginWithGoogle();
}