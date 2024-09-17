
import '../../../../core/resource/data_state.dart';
import '../../../../core/utils/function.dart';
import '../../domain/repositories/user_update_info_repository.dart';
import '../datasources/firebase_update_info.dart';

class UpdatePasswordImpl extends UpdatePassword {
  final UpdatePasswordFirebase _updatePasswordFirebase;
  UpdatePasswordImpl(this._updatePasswordFirebase);
  @override
  Future<DataState> updatePassword(String newPassword) async {
    return onStateProgress(_updatePasswordFirebase.onUpdate(newPassword));
  }
}

class UpdateUsernameImpl extends UpdateUsername {
  final UpdateUsernameFirebase _updateUsernameFirebase;
  UpdateUsernameImpl(this._updateUsernameFirebase);
  @override
  Future<DataState> updateUsername(String newUsername) async {
    return onStateProgress(_updateUsernameFirebase.onUpdate(newUsername));
  }
}

class UpdateImageImpl extends UpdateImage {
  final UpdateImageFirebase _updateImageFirebase;
  UpdateImageImpl(this._updateImageFirebase);
  @override
  Future<DataState> updateImage(String newImage) async {
    return onStateProgress(_updateImageFirebase.onUpdate(newImage));
  }
}