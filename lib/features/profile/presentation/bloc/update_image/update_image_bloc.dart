import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/update_image_use_case.dart';

part 'update_image_event.dart';
part 'update_image_state.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  UpdateImageUseCase updateImageUseCase;
  UpdateImageBloc(this.updateImageUseCase) : super(const UpdateImageInitial()) {
    on<UpdateImageEvent>((event, emit) async {
      emit(const UpdateImageLoading());
      final dataState = await updateImageUseCase(params: event.file);
      dataState.fold(
        (error) {
          log('got error');
          emit(UpdateImageFailed(error));
        },
        (data) {
          log('successful');
          emit(UpdateImageSuccessful(data));
        },
      );
    });
  }
}
