import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/resource/firebase_authentication.dart';
import 'package:happy_cooking/main.dart';

class LoginWithCredentialFirebase extends AuthenticateFirebase<void, AuthCredential> {
  @override
  Future<Either<String, void>> execute(AuthCredential? params) async {
    try {
      await auth.signInWithCredential(params!);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
