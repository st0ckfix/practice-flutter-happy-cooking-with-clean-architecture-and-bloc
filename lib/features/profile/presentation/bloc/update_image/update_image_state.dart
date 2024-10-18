part of 'update_image_bloc.dart';

abstract class UpdateImageState extends Equatable {
  final String? failedReason;
  final String? dataIfNeeded;
  const UpdateImageState({this.failedReason, this.dataIfNeeded});

  @override
  List<Object?> get props => [failedReason, dataIfNeeded];
}

final class UpdateImageInitial extends UpdateImageState {
  const UpdateImageInitial();
}

final class UpdateImageLoading extends UpdateImageState {
  const UpdateImageLoading();
}

final class UpdateImageSuccessful extends UpdateImageState {
  const UpdateImageSuccessful(String? dataIfNeeded) : super(dataIfNeeded: dataIfNeeded);
}

final class UpdateImageFailed extends UpdateImageState {
  const UpdateImageFailed(String? failedReason) : super(failedReason: failedReason);
}
