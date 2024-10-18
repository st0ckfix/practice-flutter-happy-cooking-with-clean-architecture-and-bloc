import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/update_username_use_case.dart';

part 'update_username_event.dart';
part 'update_username_state.dart';

class UpdateUsernameBloc extends Bloc<UpdateUsernameEvent, UpdateUsernameState> {
  UpdateUsernameUseCase updateUsernameUseCase;
  UpdateUsernameBloc(this.updateUsernameUseCase) : super(const UpdateUsernameInitial()) {
    on<UpdateUsernameEvent>((event, emit) async {
       emit(const UpdateUsernameLoading());
      final dataState = await updateUsernameUseCase(params: event.newUsername);
      dataState.fold(
        (error) {
          emit(UpdateUsernameFailed(error));
        },
        (_) {
          emit(const UpdateUsernameSuccessful());
        },
      );
    });
  }
}
