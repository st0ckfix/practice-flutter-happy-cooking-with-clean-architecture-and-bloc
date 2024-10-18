part of 'signup_user_bloc.dart';

abstract class SignupUserState extends Equatable {
  final String? failedReason;
  const SignupUserState({this.failedReason});

  @override
  List<Object> get props => [failedReason!];
}

final class SignupUserInitial extends SignupUserState {
  const SignupUserInitial();
}

final class SignupUserLoading extends SignupUserState {
  const SignupUserLoading();
}

final class SignupUserSuccessful extends SignupUserState {
  const SignupUserSuccessful();
}

final class SignupUserFailed extends SignupUserState {
  const SignupUserFailed(String failedReason) : super(failedReason: failedReason);
}
