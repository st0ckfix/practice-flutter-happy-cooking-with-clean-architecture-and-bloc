import 'package:firebase_auth/firebase_auth.dart';

abstract class VertifyPhoneRepository {
  Future vertifyPhone(
    String phoneNumber, {
    Function(PhoneAuthCredential) onAutoVerification,
    Function(String) onCodeSent,
    Function(Object) onException,
    Function onRequestAccepted,
    }
  );
}