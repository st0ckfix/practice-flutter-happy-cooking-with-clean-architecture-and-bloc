import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/link_account_with_credential_repository.dart';

class LinkAccountWithEmailUseCase implements UseCase<Either<String, void>, ({String email, String password})> {
  final LinkAccountWithCredentialRepository linkAccountWithCredentialRepository;
  LinkAccountWithEmailUseCase(this.linkAccountWithCredentialRepository);

  @override
  Future<Either<String, void>> call({({String email, String password})? params}) async {
    final credential = EmailAuthProvider.credential(email: params!.email, password: params.password);
    return linkAccountWithCredentialRepository.linkAccountWithCredential(credential);
  }
}
