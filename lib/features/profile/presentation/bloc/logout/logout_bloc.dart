import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/logout_use_case.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUseCase logoutUseCase;
  LogoutBloc(this.logoutUseCase) : super(const LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(const LogoutLoading());
      final state = await logoutUseCase();
      state.fold(
        (error) {
          emit(LogoutFailed(error));
        },
        (_) {
          emit(const LogoutSuccessful());
        },
      );
    });
  }
}
