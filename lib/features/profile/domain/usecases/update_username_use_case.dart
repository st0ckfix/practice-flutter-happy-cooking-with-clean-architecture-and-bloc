import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/update_username_repository.dart';

class UpdateUsernameUseCase implements UseCase<Either<String, void>, String> {
  UpdateUsernameRepository updateUsername;
  UpdateUsernameUseCase(this.updateUsername);
  @override
  Future<Either<String, void>> call({String? params}) {
    return updateUsername.updateUsername(params!);
  }
}
