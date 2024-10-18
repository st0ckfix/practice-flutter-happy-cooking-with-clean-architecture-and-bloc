import 'package:dartz/dartz.dart';

import '../../domain/repositories/link_account_with_credential_repository.dart';
import '../datasources/link_account_with_credential_firebase.dart';

class LinkAccountWithCredentialRepositoryImpl extends LinkAccountWithCredentialRepository {
  LinkAccountWithCredentialFirebase linkAccountWithCredentialFirebase;
  LinkAccountWithCredentialRepositoryImpl(this.linkAccountWithCredentialFirebase);
  @override
  Future<Either<String, void>> linkAccountWithCredential(credential) {
    return linkAccountWithCredentialFirebase.execute(credential);
  }
}
