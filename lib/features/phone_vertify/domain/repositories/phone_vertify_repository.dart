import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneVertifyRepository {
  Future phoneVertify(
    String phoneNumber, {
    Function(PhoneAuthCredential) onAuto,
    Function(String) onSuccess,
    Function(Object) onException,
    Function onDone,
    }
  );
}