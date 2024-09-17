import 'package:happy_cooking/core/resource/data_state.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/user_authentication_repository.dart';


class LoginWithEmailUseCase implements UseCase<DataState, (String, String)> {
  LoginWithEmailRepository loginWithEmail;
  LoginWithEmailUseCase(this.loginWithEmail);

  @override
  Future<DataState> call({(String, String)? params}) {
    return loginWithEmail.loginWithEmail(params!.$1, params.$2);
  }
}

class LoginWithGoogleUseCase implements UseCase<DataState, void> {
  LoginWithGoogleRepository loginWithGoogleRepository;
  LoginWithGoogleUseCase(this.loginWithGoogleRepository);

  @override
  Future<DataState> call({void params}) {
    return loginWithGoogleRepository.loginWithGoogle();
  }
}

class LoginAsGuestUseCase implements UseCase<DataState, void> {
  LoginAsGuestRepository loginAsGuestRepository;
  LoginAsGuestUseCase(this.loginAsGuestRepository);

  @override
  Future<DataState> call({void params}) {
    return loginAsGuestRepository.loginAsGuest();
  }
}

class SignupEmailUseCase implements UseCase<DataState, (String, String, String)> {
  SignupUserRepository signupUserRepository;
  SignupEmailUseCase(this.signupUserRepository);

  @override
  Future<DataState> call({(String, String, String)? params}) {
    return signupUserRepository.signupUser(params!.$1, params.$2, params.$3);
  }
}

class LogoutUseCase implements UseCase<DataState, void> {
  LogoutUserRepository logoutUserRepository;
  LogoutUseCase(this.logoutUserRepository);

  @override
  Future<DataState> call({void params}) {
    return logoutUserRepository.logoutUser();
  }
}

class ResetPasswordUseCase implements UseCase<DataState, String> {
  ResetPasswordRepository resetPasswordRepository;
  ResetPasswordUseCase(this.resetPasswordRepository);

  @override
  Future<DataState> call({String? params}) {
    return resetPasswordRepository.resetPassword(params!);
  }
}

class VertifyWithEmailUseCase implements UseCase<DataState, (int, String)> {
  VertifyWithEmailRepository vertifyWithEmailRepository;
  VertifyWithEmailUseCase(this.vertifyWithEmailRepository);

  @override
  Future<DataState> call({(int, String)? params}) {
    return vertifyWithEmailRepository.vertifyWithEmail(params!.$1, params.$2);
  }
}
