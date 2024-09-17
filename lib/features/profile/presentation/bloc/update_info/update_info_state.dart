part of 'update_info_bloc.dart';

abstract class UpdateInfoState extends Equatable {
  final String? failedReason;
  final DioException? dioException;
  const UpdateInfoState({this.failedReason , this.dioException});
  
  @override
  List<Object> get props => [dioException!];
}

final class UpdateInfoInitial extends UpdateInfoState {
  const UpdateInfoInitial();
}

final class UpdateInfoLoading extends UpdateInfoState {
  const UpdateInfoLoading();
}

final class UpdateInfoSuccessful extends UpdateInfoState {
  const UpdateInfoSuccessful() : super();
}

final class UpdateInfoFailed extends UpdateInfoState {
  const UpdateInfoFailed(String failedReason) : super(failedReason: failedReason);
}

final class UpdateInfoException extends UpdateInfoState {
  const UpdateInfoException(DioException exception) : super(dioException: exception);
}