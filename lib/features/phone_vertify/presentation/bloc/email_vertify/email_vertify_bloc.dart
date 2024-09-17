import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/domain/usecases/email_vertify_usecase.dart';

part 'email_vertify_event.dart';
part 'email_vertify_state.dart';

class EmailVertifyBloc extends Bloc<EmailVertifyEvent, EmailVertifyState> {
  EmailVertifyUseCase emailVertifyUseCase;
  EmailVertifyBloc(this.emailVertifyUseCase) : super(const EmailVertifyInitial()) {
    on<EmailVertifyEvent>((event, emit) async {
      emit(const EmailVertifyLoading());
      final result = await emailVertifyUseCase();
      result.fold(
        (error) {
          emit(EmailVertifyFailed(error));
        },
        (data) {
          emit(EmailVertifySuccessful(data));
        },
      );
    });
  }
}
