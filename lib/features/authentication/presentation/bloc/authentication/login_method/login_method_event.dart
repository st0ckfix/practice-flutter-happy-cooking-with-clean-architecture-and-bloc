part of 'login_method_bloc.dart';

abstract class LoginMethodEvent extends Equatable {
  const LoginMethodEvent();

  @override
  List<Object> get props => [];
}

final class LoginWithEmailEvent extends LoginMethodEvent {
  final String email;
  final String password;
  const LoginWithEmailEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class LoginWithGoogleEvent extends LoginMethodEvent {
  const LoginWithGoogleEvent();
}

final class LoginAsGuestEvent extends LoginMethodEvent {
  const LoginAsGuestEvent();
}
