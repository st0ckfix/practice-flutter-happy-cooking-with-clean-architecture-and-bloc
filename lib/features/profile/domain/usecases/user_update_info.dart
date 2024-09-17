import '../../../../core/resource/data_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_update_info_repository.dart';

class UpdatePasswordUseCase implements UseCase<DataState, String> {
  UpdatePassword updatePassword;

  UpdatePasswordUseCase(this.updatePassword);

  @override
  Future<DataState> call({String? params}) {
    return updatePassword.updatePassword(params!);
  }
}

class UpdateUsernameUseCase implements UseCase<DataState, String> {
  UpdateUsername updateUsername;

  UpdateUsernameUseCase(this.updateUsername);

  @override
  Future<DataState> call({String? params}) {
    return updateUsername.updateUsername(params!);
  }
}


class UpdateImageUseCase implements UseCase<DataState, String> {
  UpdateImage updateImage;

  UpdateImageUseCase(this.updateImage);

  @override
  Future<DataState> call({String? params}) {
    return updateImage.updateImage(params!);
  }
}
