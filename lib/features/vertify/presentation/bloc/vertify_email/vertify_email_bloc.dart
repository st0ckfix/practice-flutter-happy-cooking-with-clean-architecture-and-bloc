import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/vertify_email_usecase.dart';

part 'vertify_email_event.dart';
part 'vertify_email_state.dart';

class VertifyEmailBloc extends Bloc<VertifyEmailEvent, VertifyEmailState> {
  VertifyEmailUseCase vertifyEmailUseCase;
  VertifyEmailBloc(this.vertifyEmailUseCase) : super(const VertifyEmailInitial()) {
    on<VertifyEmailEvent>((event, emit) async {
      emit(const VertifyEmailLoading());
      final result = await vertifyEmailUseCase(params: event.email);
      result.fold(
        (error) {
          emit(VertifyEmailFailed(error));
        },
        (data) {
          emit(VertifyEmailSuccessful(data));
        },
      );
    });
  }
}
