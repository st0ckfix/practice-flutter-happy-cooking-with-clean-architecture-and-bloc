part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  final String? failedReason;
  const LogoutState({this.failedReason});

  @override
  List<Object?> get props => [failedReason];
}

final class LogoutInitial extends LogoutState {
  const LogoutInitial();
}

final class LogoutLoading extends LogoutState {
  const LogoutLoading();
}

final class LogoutSuccessful extends LogoutState {
  const LogoutSuccessful();
}

final class LogoutFailed extends LogoutState {
  const LogoutFailed(String? failedReason) : super(failedReason: failedReason);
}
