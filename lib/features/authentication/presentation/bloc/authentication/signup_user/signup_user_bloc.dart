import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/signup_with_email_use_case.dart';

part 'signup_user_event.dart';
part 'signup_user_state.dart';

class SignupUserBloc extends Bloc<SignupUserEvent, SignupUserState> {
  final SignupWithEmailUseCase signupEmailUseCase;
  SignupUserBloc(this.signupEmailUseCase) : super(const SignupUserInitial()) {
    on<SignupUserEvent>(
      (event, emit) async {
        emit(const SignupUserLoading());
        final dataState = await signupEmailUseCase(params: (email: event.email, password: event.password, username: event.username));
        dataState.fold(
          (error) {
            emit(SignupUserFailed(error));
          },
          (_) {
            emit(const SignupUserSuccessful());
          },
        );
      },
    );
  }
}
