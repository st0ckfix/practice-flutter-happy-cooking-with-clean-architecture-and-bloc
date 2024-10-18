import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/resource/firebase_authentication.dart';
import 'package:happy_cooking/main.dart';

class LoginWithEmailFirebase extends AuthenticateFirebase<void, ({String email, String password})> {
  LoginWithEmailFirebase();
  @override
  Future<Either<String, void>> execute(({String email, String password})? params) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: params!.email,
        password: params.password,
      );
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
