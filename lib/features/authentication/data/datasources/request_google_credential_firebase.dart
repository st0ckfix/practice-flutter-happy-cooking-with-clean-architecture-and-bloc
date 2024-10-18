import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/resource/firebase_authentication.dart';

class RequestGoogleCredentialFirebase extends AuthenticateFirebase<OAuthCredential, void> {
  @override
  Future<Either<String, OAuthCredential>> execute(void params) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
