import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/resource/data_state.dart';
import '../../../../domain/usecases/user_authentication.dart';

part 'signup_user_event.dart';
part 'signup_user_state.dart';

class SignupUserBloc extends Bloc<SignupUserEvent, SignupUserState> {
  final SignupEmailUseCase signupEmailUseCase;
  SignupUserBloc(this.signupEmailUseCase) : super(const SignupUserInitial()) {
    on<SignupUserEvent>(
      (event, emit) async {
        emit(const SignupUserLoading());
        final dataState = await signupEmailUseCase(params: (event.email, event.password, event.username));
        if (dataState is DataSuccess) {
          emit(const SignupUserSuccessful());
        } else if (dataState is DataFailed) {
          emit(SignupUserFailed(dataState.message as String));
        } else {
          emit(SignupUserException(dataState.exception!));
        }
      },
    );
  }
}
