import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/link_account_with_credential_repository.dart';

class LinkAccountWithPhoneUseCase implements UseCase<Either<String, void>, PhoneAuthCredential> {
  final LinkAccountWithCredentialRepository linkAccountWithCredentialRepository;
  LinkAccountWithPhoneUseCase(this.linkAccountWithCredentialRepository);
  @override
  Future<Either<String, void>> call({PhoneAuthCredential? params}) {
    return linkAccountWithCredentialRepository.linkAccountWithCredential(params!);
  }
}
