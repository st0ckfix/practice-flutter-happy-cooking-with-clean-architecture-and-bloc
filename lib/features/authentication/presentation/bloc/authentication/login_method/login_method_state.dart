part of 'login_method_bloc.dart';

abstract class LoginMethodState<T> extends Equatable {
  final T? data;
  final String? failedReason;
  const LoginMethodState({this.failedReason, this.data});

  @override
  List<Object> get props => [failedReason!, data!];
}

final class LoginMethodInitial extends LoginMethodState {
  const LoginMethodInitial();
}

final class LoginMethodLoading extends LoginMethodState {
  const LoginMethodLoading();
}

final class LoginMethodSuccessful<T> extends LoginMethodState {
  const LoginMethodSuccessful(T? data) : super(data: data);
}

final class LoginMethodFailed extends LoginMethodState {
  const LoginMethodFailed(String failedReason) : super(failedReason: failedReason);
}
