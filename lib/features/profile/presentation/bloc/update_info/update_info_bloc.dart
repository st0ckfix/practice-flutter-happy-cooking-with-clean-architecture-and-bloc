import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/resource/data_state.dart';
import '../../../domain/usecases/user_update_info.dart';

part 'update_info_event.dart';
part 'update_info_state.dart';

class UpdateInfoBloc extends Bloc<UpdateInfoEvent, UpdateInfoState> {
  UpdatePasswordUseCase updatePasswordUseCase;
  UpdateUsernameUseCase updateUsernameUseCase;
  UpdateImageUseCase updateImageUseCase;
  UpdateInfoBloc(this.updateImageUseCase, this.updatePasswordUseCase, this.updateUsernameUseCase) : super(const UpdateInfoInitial()) {
    on<UpdatePasswordEvent>((event, emit) => onUpdateEvent(emit, updatePasswordUseCase(params: event.password)));
    on<UpdateUsernameEvent>((event, emit) => onUpdateEvent(emit, updateUsernameUseCase(params: event.newUsername)));
    on<UpdateImageEvent>((event, emit) => onUpdateEvent(emit, updateImageUseCase(params: event.newImage)));
  }

  Future<void> onUpdateEvent(Emitter emit, Future<DataState> fuction) async {
    emit(const UpdateInfoLoading());
    final dataState = await fuction;
    if (dataState is DataSuccess) {
      emit(const UpdateInfoSuccessful());
    } else if (dataState is DataFailed) {
      emit(UpdateInfoFailed(dataState.message as String));
    } else {
      emit(UpdateInfoException(dataState.exception!));
    }
  }
}
