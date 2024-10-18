part of 'update_username_bloc.dart';

abstract class UpdateUsernameState extends Equatable {
  final String? failedReason;
  const UpdateUsernameState({this.failedReason});

  @override
  List<Object?> get props => [failedReason];
}

final class UpdateUsernameInitial extends UpdateUsernameState {
  const UpdateUsernameInitial();
}

final class UpdateUsernameLoading extends UpdateUsernameState {
  const UpdateUsernameLoading();
}

final class UpdateUsernameSuccessful extends UpdateUsernameState {
  const UpdateUsernameSuccessful() : super();
}

final class UpdateUsernameFailed extends UpdateUsernameState {
  const UpdateUsernameFailed(String? failedReason) : super(failedReason: failedReason);
}