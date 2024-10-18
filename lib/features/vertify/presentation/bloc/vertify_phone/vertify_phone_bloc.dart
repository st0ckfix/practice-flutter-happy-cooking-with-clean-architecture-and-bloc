import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/vertify/domain/usecases/vertify_phone_usecase.dart';

part 'vertify_phone_event.dart';
part 'vertify_phone_state.dart';

class VertifyPhoneBloc extends Bloc<VertifyPhoneEvent, VertifyPhoneState> {
  VertifyPhoneUseCase vertifyPhoneUseCase;
  VertifyPhoneBloc(this.vertifyPhoneUseCase) : super(const VertifyPhoneInitial()) {
    on<VertifyPhoneEvent>(
      (event, emit) async {
        emit(const VertifyPhoneLoading());
        await vertifyPhoneUseCase(
          params: (
            event.phoneNumber,
            onAutoVerification: (phoneCredential) async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(VertifyPhoneAutoVerification(phoneCredential));
            },
            onException: (exception) async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(VertifyPhoneException(DioException(requestOptions: RequestOptions())));
            },
            onCodeSent: (verificationId) async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(VertifyPhoneCodeSent(verificationId));
            },
            onRequestAccepted: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              emit(const VertifyPhoneRequestAccepted());
            }
          ),
        );
        if (!emit.isDone) emit(const VertifyPhoneTimeout());
      },
    );
  }
}
