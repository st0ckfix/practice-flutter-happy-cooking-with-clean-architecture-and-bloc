part of 'update_username_bloc.dart';

final class UpdateUsernameEvent extends Equatable {
  final String newUsername;
  const UpdateUsernameEvent(this.newUsername);

  @override
  List<Object> get props => [newUsername];
}
