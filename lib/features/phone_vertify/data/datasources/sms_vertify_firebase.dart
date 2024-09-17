import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/pages/vertify_page.dart';

class PhoneVertifySMSCodeFirebase {
  Future<Either<String, UserCredential>> smsVertify({String? verificationId, String? smsCode, PhoneAuthCredential? phoneAuthCredential}) async {
    try {
      final userCredential = await auth.signInWithCredential(
        phoneAuthCredential ??
            PhoneAuthProvider.credential(
              verificationId: verificationId!,
              smsCode: smsCode!,
            ),
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
