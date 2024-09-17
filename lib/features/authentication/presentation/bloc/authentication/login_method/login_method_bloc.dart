import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resource/data_state.dart';
import '../../../../domain/usecases/user_authentication.dart';

part 'login_method_event.dart';
part 'login_method_state.dart';

class LoginMethodBloc extends Bloc<LoginMethodEvent, LoginMethodState> {
  final LoginWithEmailUseCase loginWithEmailUserCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LoginAsGuestUseCase loginAsGuestUseCase;

  LoginMethodBloc(this.loginWithEmailUserCase, this.loginAsGuestUseCase, this.loginWithGoogleUseCase) : super(const LoginMethodInitial()) {
    on<LoginWithEmailEvent>(
      (event, emit) async => await onLoginEvent(
        emit,
        loginWithEmailUserCase(
          params: (event.email, event.password),
        ),
      ),
    );
    on<LoginWithGoogleEvent>(
      (event, emit) async => await onLoginEvent(
        emit,
        loginWithGoogleUseCase(),
      ),
    );
    on<LoginAsGuestEvent>(
      (event, emit) async => await onLoginEvent(
        emit,
        loginAsGuestUseCase(),
      ),
    );
  }

  Future<void> onLoginEvent(Emitter emit, Future<DataState> fuction) async {
    emit(const LoginMethodLoading());
    final dataState = await fuction;
    if (dataState is DataSuccess) {
      emit(const LoginMethodSuccessful());
    } else if (dataState is DataFailed) {
      emit(LoginMethodFailed(dataState.data as String));
    } else {
      emit(LoginMethodException(dataState.exception!));
    }
  }
}
