part of 'login_method_bloc.dart';

abstract class LoginMethodState extends Equatable {
  final String? failedReason;
  final DioException? dioException;

  const LoginMethodState({this.failedReason, this.dioException});

  @override
  List<Object> get props => [failedReason!, dioException!];
}

final class LoginMethodInitial extends LoginMethodState {
  const LoginMethodInitial();
}

final class LoginMethodLoading extends LoginMethodState {
  const LoginMethodLoading();
}

final class LoginMethodSuccessful extends LoginMethodState {
  const LoginMethodSuccessful() : super();
}

final class LoginMethodFailed extends LoginMethodState {
  const LoginMethodFailed(String failedReason) : super(failedReason: failedReason);
}

final class LoginMethodException extends LoginMethodState {
  const LoginMethodException(DioException exception) : super(dioException: exception);
}
