import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';

import '../repositories/signup_with_email_repository.dart';

class SignupWithEmailUseCase implements UseCase<Either<String, void>, ({String email, String password, String username})> {
  SignupWithEmailRepository signupWithEmailRepository;
  SignupWithEmailUseCase(this.signupWithEmailRepository);

  @override
  Future<Either<String, void>> call({({String email, String password, String username})? params}) {
    return signupWithEmailRepository.signupWithEmail(params!.email, params.password, params.username);
  }
}
