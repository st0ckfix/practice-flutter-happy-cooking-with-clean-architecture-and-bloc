import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/vertify_phone_repository.dart';

class VertifyPhoneUseCase
    implements
        UseCase<
            void,
            (
              String phoneNumber, {
              Function(Object) onException,
              Function(PhoneAuthCredential) onAutoVerification,
              Function(String) onCodeSent,
              Function onRequestAccepted,
            })> {
  VertifyPhoneRepository vertifyPhoneRepository;
  VertifyPhoneUseCase(this.vertifyPhoneRepository);

  @override
  Future call(
      {(
        String, {
        Function(PhoneAuthCredential p1) onAutoVerification,
        Function(Object p1) onException,
        Function(String p1) onCodeSent,
        Function onRequestAccepted,
      })? params}) {
    return vertifyPhoneRepository.vertifyPhone(
      params!.$1,
      onAutoVerification: params.onAutoVerification,
      onException: params.onException,
      onCodeSent: params.onCodeSent,
      onRequestAccepted: params.onRequestAccepted,
    );
  }
}
