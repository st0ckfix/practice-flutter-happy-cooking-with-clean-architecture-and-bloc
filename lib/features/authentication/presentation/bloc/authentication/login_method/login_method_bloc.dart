import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/login_with_email_use_case.dart';
import '../../../../domain/usecases/request_google_credential_use_case.dart';
import '../../../../domain/usecases/login_with_phone_use_case.dart';

part 'login_method_event.dart';
part 'login_method_state.dart';

class LoginMethodBloc extends Bloc<LoginMethodEvent, LoginMethodState> {
  final LoginWithEmailUseCase loginWithEmailUserCase;
  final RequestGoogleCredentialUseCase requestGoogleCredentialUseCase;
  final LoginWithPhoneUseCase loginWithPhoneUseCase;

  LoginMethodBloc(
    this.loginWithEmailUserCase,
    this.requestGoogleCredentialUseCase,
    this.loginWithPhoneUseCase,
  ) : super(const LoginMethodInitial()) {
    on<LoginWithEmailEvent>(
      (event, emit) async => await onLoginEvent(emit, loginWithEmailUserCase(params: (email: event.email, password: event.password))),
    );
    on<LoginWithGoogleEvent>(
      (event, emit) async => await onLoginEvent(emit, requestGoogleCredentialUseCase()),
    );
    on<LoginWithPhoneEvent>(
      (event, emit) async => await onLoginEvent(emit, loginWithPhoneUseCase(params: event.phoneAuthCredential)),
    );
  }

  Future<void> onLoginEvent(Emitter emit, Future<Either<String, dynamic>> fuction) async {
    emit(const LoginMethodLoading());
    final dataState = await fuction;
    dataState.fold(
      (error) {
        emit(LoginMethodFailed(error));
      },
      (data) {
        emit(LoginMethodSuccessful(data));
      },
    );
  }
}
