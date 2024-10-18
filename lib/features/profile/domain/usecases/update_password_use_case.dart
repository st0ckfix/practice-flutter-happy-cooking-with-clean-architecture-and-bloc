import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_password_repository.dart';

class UpdatePasswordUseCase implements UseCase<Either<String, void>, String> {
  UpdatePasswordRepository updatePassword;
  UpdatePasswordUseCase(this.updatePassword);

  @override
  Future<Either<String, void>> call({String? params}) {
    return updatePassword.updatePassword(params!);
  }
}
