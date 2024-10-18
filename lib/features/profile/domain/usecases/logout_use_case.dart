import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/logout_repository.dart';

class LogoutUseCase implements UseCase<Either<String, void>, void> {
  LogoutRepository logoutRepository;
  LogoutUseCase(this.logoutRepository);

  @override
  Future<Either<String, void>> call({void params}) {
    return logoutRepository.logout();
  }
}
