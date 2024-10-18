import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/vertify_phone_repository.dart';
import '../datasources/vertify_phone_firebase.dart';

class VertifyPhoneRepositoryImpl extends VertifyPhoneRepository {
  final VertifyPhoneFirebase _vertifyPhoneFirebase;
  VertifyPhoneRepositoryImpl(this._vertifyPhoneFirebase);

  @override
  Future vertifyPhone(
    String phoneNumber, {
    Function(PhoneAuthCredential phoneCreadential)? onAutoVerification,
    Function(String verificationId)? onCodeSent,
    Function(Object exception)? onException,
    Function? onRequestAccepted,
  }) async {
    try {
      await _vertifyPhoneFirebase.vertifyPhone(
        phoneNumber,
        onAutoVerification: (phoneCreadential) {
          onAutoVerification!(phoneCreadential);
        },
        onCodeSent: (verificationId) {
          onCodeSent!(verificationId);
        },
        onRequestAccepted:() => onRequestAccepted!(),
      );
    } catch (e){
      onException!(e);
    }
  }
}

