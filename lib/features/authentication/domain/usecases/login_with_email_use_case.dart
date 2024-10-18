import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/login_with_email_repository.dart';

class LoginWithEmailUseCase implements UseCase<Either<String, void>, ({String email, String password})> {
  LoginWithEmailRepository loginWithEmail;
  LoginWithEmailUseCase(this.loginWithEmail);

  @override
  Future<Either<String, void>> call({({String email, String password})? params}) {
    return loginWithEmail.loginWithEmail(params!.email, params.password);
  }
}
