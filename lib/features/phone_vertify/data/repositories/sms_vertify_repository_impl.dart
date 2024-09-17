import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/sms_vertify_repository.dart';
import '../datasources/sms_vertify_firebase.dart';

class PhoneVertifySMSCodeRepositoryImpl extends PhoneVertifySMSCodeRepository {
  final PhoneVertifySMSCodeFirebase _phoneVertifySMSCodeFirebase;
  PhoneVertifySMSCodeRepositoryImpl(this._phoneVertifySMSCodeFirebase);
  @override
  Future<Either<String, UserCredential>> smsVertify({PhoneAuthCredential? phoneAuthCredential, String? verificationId, String? smsCode}) {
    return _phoneVertifySMSCodeFirebase.smsVertify(phoneAuthCredential: phoneAuthCredential, verificationId: verificationId, smsCode: smsCode);
  }
}
