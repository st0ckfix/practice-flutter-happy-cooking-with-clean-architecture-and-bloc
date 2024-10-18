part of 'update_image_bloc.dart';

final class UpdateImageEvent extends Equatable {
  final File file;
  const UpdateImageEvent(this.file);

  @override
  List<Object> get props => [file];
}
