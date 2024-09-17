import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/pages/vertify_page.dart';

class PhoneVertifyFirebase {
  Future phoneVertify(
    String phoneNumber, {
    Function(PhoneAuthCredential credential)? onAuto,
    Function(String verificationId)? onSuccess,
    Function? onDone,
  }) async {
    final Completer completer = Completer<dynamic>();
    try {
      log('request-send-sms-otp');

      await auth
          .verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (credential) {
          log('auto-code');
          onAuto!(credential);
        },
        verificationFailed: (exeption) {
          log('exception');
          completer.completeError(exeption.code);
        },
        codeSent: (verificationId, _) {
          log('code-sent');
          onSuccess!(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log('time-out');
          completer.complete(verificationId);
        },
      )
          .then((value) {
        onDone!();
      });
    } on FirebaseAuthException catch (e) {
      log('firebase-exception ${e.code}');
      completer.completeError(e.code);
    } catch (e) {
      log('error-exception $e');
      completer.completeError(e);
    }
    return completer.future;
  }
}