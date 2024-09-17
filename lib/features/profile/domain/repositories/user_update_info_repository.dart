import '../../../../core/resource/data_state.dart';

abstract class UpdatePassword {
  Future<DataState> updatePassword(String newPassword);
}

abstract class UpdateUsername {
  Future<DataState> updateUsername(String newUsername);
}

abstract class UpdateImage {
  Future<DataState> updateImage(String newImage);
}