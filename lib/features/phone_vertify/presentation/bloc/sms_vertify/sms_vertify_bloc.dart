import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/sms_vertify_usecase.dart';

part 'sms_vertify_event.dart';
part 'sms_vertify_state.dart';

class PhoneVertifySMSCodeBloc extends Bloc<PhoneVertifySMSCodeEvent, PhoneVertifySMSCodeState> {
  final PhoneVertifySMSCodeUseCase phoneVertifySMSCodeUseCase;
  PhoneVertifySMSCodeBloc(this.phoneVertifySMSCodeUseCase) : super(const PhoneVertifySMSCodeInitial()) {
    on<PhoneVertifySMSCodeEvent>(
      (event, emit) async {
        final result = await phoneVertifySMSCodeUseCase(params: (
          phoneAuthCredential: event.phoneAuthCredential,
          smsCode: event.smsCode,
          verificationId: event.verificationId,
        ));

        result.fold(
          (error) {
            emit(PhoneVertifySMSCodeFailed(error));
          },
          (data) {
            emit(const PhoneVertifySMSCodeSuccessful());
          },
        );
      },
    );
  }
}
