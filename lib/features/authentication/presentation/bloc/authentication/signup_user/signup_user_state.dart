part of 'signup_user_bloc.dart';

abstract class SignupUserState extends Equatable {
  final String? failedReason;
  final DioException? dioException;
  const SignupUserState({this.failedReason, this.dioException});

  @override
  List<Object> get props => [failedReason!, dioException!];
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

final class SignupUserException extends SignupUserState {
  const SignupUserException(DioException exception) : super(dioException: exception);
}
