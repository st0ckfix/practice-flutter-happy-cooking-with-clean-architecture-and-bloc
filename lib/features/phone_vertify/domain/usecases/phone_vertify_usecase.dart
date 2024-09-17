import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/phone_vertify_repository.dart';

class PhoneVertifyUseCase
    implements
        UseCase<
            void,
            (
              String phoneNumber, {
              Function(Object) onException,
              Function(PhoneAuthCredential) onAuto,
              Function(String) onSuccess,
              Function onDone,
            })> {
  PhoneVertifyRepository phoneVertifyRepository;
  PhoneVertifyUseCase(this.phoneVertifyRepository);

  @override
  Future call(
      {(
        String, {
        Function(PhoneAuthCredential p1) onAuto,
        Function(Object p1) onException,
        Function(String p1) onSuccess,
        Function onDone,
      })? params}) {
    return phoneVertifyRepository.phoneVertify(
      params!.$1,
      onAuto: params.onAuto,
      onException: params.onException,
      onSuccess: params.onSuccess,
      onDone: params.onDone,
    );
  }
}
