import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/pages/vertify_page.dart';

class VertifyPhoneFirebase {
  Future vertifyPhone(
    String phoneNumber, {
    Function(PhoneAuthCredential credential)? onAutoVerification,
    Function(String verificationId)? onCodeSent,
    Function? onRequestAccepted,
  }) async {
    final Completer completer = Completer();
    try {
      log('request-send-sms-otp');
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 50),
        verificationCompleted: (credential) {
          log('auto-code');
          onAutoVerification!(credential);
        },
        verificationFailed: (exeption) {
          log('exception');
          completer.completeError(exeption.code);
        },
        codeSent: (verificationId, _) {
          log('code-sent');
          onCodeSent!(verificationId);
        },
        codeAutoRetrievalTimeout: (_) {
          log('time-out');
          completer.complete();
        },
      );
      onRequestAccepted!();
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
