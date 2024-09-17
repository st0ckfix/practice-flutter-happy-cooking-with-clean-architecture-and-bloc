import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/features/phone_vertify/domain/repositories/sms_vertify_repository.dart';

import '../../../../core/usecases/usecase.dart';

class PhoneVertifySMSCodeUseCase
    implements
        UseCase<
            Either<dynamic, UserCredential>,
            ({
              PhoneAuthCredential? phoneAuthCredential,
              String? verificationId,
              String? smsCode,
            })> {
  PhoneVertifySMSCodeRepository phoneVertifySMSCodeRepository;
  PhoneVertifySMSCodeUseCase(this.phoneVertifySMSCodeRepository);

  @override
  Future<Either<String, UserCredential>> call({({PhoneAuthCredential? phoneAuthCredential, String? smsCode, String? verificationId})? params}) {
    return phoneVertifySMSCodeRepository.smsVertify(
      phoneAuthCredential: params!.phoneAuthCredential,
      verificationId: params.verificationId,
      smsCode: params.smsCode,
    );
  }
}