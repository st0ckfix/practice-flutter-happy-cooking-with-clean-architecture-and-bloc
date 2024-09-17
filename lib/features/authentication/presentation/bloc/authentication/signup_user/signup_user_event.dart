part of 'signup_user_bloc.dart';

class SignupUserEvent extends Equatable {
  final String email;
  final String password;
  final String username;
  const SignupUserEvent(this.email, this.password, this.username);

  @override
  List<Object> get props => [email, password, username];
}