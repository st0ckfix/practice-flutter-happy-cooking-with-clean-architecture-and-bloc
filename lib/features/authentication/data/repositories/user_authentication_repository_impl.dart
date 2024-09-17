import 'dart:async';
import 'package:happy_cooking/core/resource/data_state.dart';
import 'package:happy_cooking/features/authentication/data/datasources/firebase_authentication.dart';
import '../../../../core/utils/function.dart';
import '../../domain/repositories/user_authentication_repository.dart';

class LoginWithEmailRepositoryImpl extends LoginWithEmailRepository {
  final LoginWithEmailFirebase _loginWithEmailFirebase;
  LoginWithEmailRepositoryImpl(this._loginWithEmailFirebase);
  @override
  Future<DataState> loginWithEmail(String email, String password) async {
    return onStateProgress(_loginWithEmailFirebase.onLogin(email, password));
  }
}

class LoginWithGoogleRepositoryImpl extends LoginWithGoogleRepository {
  final LoginWithGoogleFirebase _loginWithGoogleFirebase;
  LoginWithGoogleRepositoryImpl(this._loginWithGoogleFirebase);
  @override
  Future<DataState> loginWithGoogle() async {
    return onStateProgress(_loginWithGoogleFirebase.onLogin());
  }
}

class LoginAsGuestRepositoryImpl extends LoginAsGuestRepository {
  final LoginAsGuestFirebase _loginAsGuestFirebase;
  LoginAsGuestRepositoryImpl(this._loginAsGuestFirebase);

  @override
  Future<DataState> loginAsGuest() {
    return onStateProgress(_loginAsGuestFirebase.onLogin());
  }
}

class SignupUserRepositoryImpl extends SignupUserRepository {
  final SignupUserFirebase _signupUserFirebase;
  SignupUserRepositoryImpl(this._signupUserFirebase);

  @override
  Future<DataState> signupUser(String email, String password, String username) {
    return onStateProgress(_signupUserFirebase.onSignup(email, password, username));
  }
}

class LogoutUserRepositoryImpl extends LogoutUserRepository {
  final LogoutFirebase _logoutFirebase;
  LogoutUserRepositoryImpl(this._logoutFirebase);
  @override
  Future<DataState> logoutUser() {
    return onStateProgress(_logoutFirebase.onLogout());
  }
}

class ResetPasswordRepositoryImpl extends ResetPasswordRepository {
  final ResetpasswordFirebase resetpasswordFirebase;
  ResetPasswordRepositoryImpl(this.resetpasswordFirebase);
  @override
  Future<DataState> resetPassword(String email) {
    return onStateProgress(resetpasswordFirebase.onReset(email));
  }
}
