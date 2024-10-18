import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/features/profile/presentation/pages/profile_page.dart';

import '../../../../core/resource/firebase_authentication.dart';

class LinkAccountWithCredentialFirebase extends AuthenticateFirebase<void, AuthCredential> {
  LinkAccountWithCredentialFirebase();

  @override
  Future<Either<String, void>> execute(AuthCredential? params) async {
    try {
      await user.linkWithCredential(params!);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
