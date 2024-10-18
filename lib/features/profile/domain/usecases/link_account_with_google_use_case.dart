import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/domain/repository/authentication_repository.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/link_account_with_credential_repository.dart';

class LinkAccountWithGoogleUseCase implements UseCase<Either<String, OAuthCredential>, void> {
  final RequestGoogleCredentialRepository requestGoogleCredentialRepository;
  final LinkAccountWithCredentialRepository linkAccountWithCredentialRepository;
  LinkAccountWithGoogleUseCase(this.requestGoogleCredentialRepository, this.linkAccountWithCredentialRepository);

  @override
  Future<Either<String, OAuthCredential>> call({void params}) async {
    final result = await requestGoogleCredentialRepository.requestGoogleCredential();
    result.fold(
      (error) {
        return Left(error);
      },
      (credential) {
        return linkAccountWithCredentialRepository.linkAccountWithCredential(credential);
      },
    );
    return Left(getErrorMessage('...'));
  }
}
