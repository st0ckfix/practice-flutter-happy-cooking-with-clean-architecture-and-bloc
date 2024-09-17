import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/domain/usecases/phone_vertify_usecase.dart';

part 'phone_vertify_event.dart';
part 'phone_vertify_state.dart';

class PhoneVertifyBloc extends Bloc<PhoneVertifyEvent, PhoneVertifyState> {
  PhoneVertifyUseCase phoneVertifyUseCase;
  PhoneVertifyBloc(this.phoneVertifyUseCase) : super(const PhoneVertifyInitial()) {
    on<PhoneVertifyEvent>(
      (event, emit) async {
        emit(const PhoneVertifyLoading());
        final state = await phoneVertifyUseCase(
          params: (
            event.phoneNumber,
            onAuto: (phoneCredential) async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(PhoneVertifySMSAutoComplete(phoneCredential));
            },
            onException: (exception) async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(PhoneVertifyException(DioException(requestOptions: RequestOptions())));
            },
            onSuccess: (verificationId) async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(PhoneVertifySMSSent(verificationId));
            },
            onDone: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(const PhoneVertifyRequestDone());
            }
          ),
        );
        if (!emit.isDone) emit(PhoneVertifyTimeout(state));
      },
    );
  }
}
