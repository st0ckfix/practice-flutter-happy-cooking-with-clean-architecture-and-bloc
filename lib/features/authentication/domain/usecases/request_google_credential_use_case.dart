import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/domain/repository/authentication_repository.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/login_with_credential_repository.dart';

class RequestGoogleCredentialUseCase implements UseCase<Either<String, OAuthCredential>, void> {
  RequestGoogleCredentialRepository requestGoogleCredentialRepository;
  LoginWithCredentialRepository loginWithCredentialRepository;
  RequestGoogleCredentialUseCase(this.requestGoogleCredentialRepository, this.loginWithCredentialRepository);

  @override
  Future<Either<String, OAuthCredential>> call({void params}) async {
    final state = await requestGoogleCredentialRepository.requestGoogleCredential();
    state.fold(
      (error) {
        return Left(error);
      },
      (credential) {
        return loginWithCredentialRepository.loginWithCredential(credential);
      },
    );
    return Left(getErrorMessage('...'));
  }
}
