part of 'update_info_bloc.dart';

abstract class UpdateInfoEvent extends Equatable {
  const UpdateInfoEvent();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordEvent extends UpdateInfoEvent {
  final String? email;
  final String password;
  const UpdatePasswordEvent(this.email , this.password);

  @override
  List<Object> get props => [email!, password];
}

final class UpdateUsernameEvent extends UpdateInfoEvent {
  final String newUsername;
  const UpdateUsernameEvent(this.newUsername);

  @override
  List<Object> get props => [newUsername];
}

final class UpdateImageEvent extends UpdateInfoEvent {
  final String newImage;
  const UpdateImageEvent(this.newImage);

  @override
  List<Object> get props => [newImage];
}
