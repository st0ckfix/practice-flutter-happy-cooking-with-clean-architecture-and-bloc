import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/login_with_credential_repository.dart';

class LoginWithPhoneUseCase implements UseCase<Either<String, void>, PhoneAuthCredential> {
  final LoginWithCredentialRepository loginWithCredentialRepository;
  LoginWithPhoneUseCase(this.loginWithCredentialRepository);
  @override
  Future<Either<String, void>> call({PhoneAuthCredential? params}) {
    return loginWithCredentialRepository.loginWithCredential(params!);
  }
}
