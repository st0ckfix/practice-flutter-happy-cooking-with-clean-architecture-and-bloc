import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/phone_vertify_repository.dart';
import '../datasources/phone_vertify_firebase.dart';

class PhoneVertifyRepositoryImpl extends PhoneVertifyRepository {
  final PhoneVertifyFirebase _phoneVertifyFirebase;
  PhoneVertifyRepositoryImpl(this._phoneVertifyFirebase);

  @override
  Future phoneVertify(
    String phoneNumber, {
    Function(PhoneAuthCredential phoneCreadential)? onAuto,
    Function(String verificationId)? onSuccess,
    Function(Object exception)? onException,
    Function? onDone,
  }) async {
    try {
      await _phoneVertifyFirebase.phoneVertify(
        phoneNumber,
        onAuto: (phoneCreadential) {
          onAuto!(phoneCreadential);
        },
        onSuccess: (verificationId) {
          onSuccess!(verificationId);
        },
        onDone:() => onDone!()
      );
    } catch (e){
      onException!(e);
    }
  }
}

