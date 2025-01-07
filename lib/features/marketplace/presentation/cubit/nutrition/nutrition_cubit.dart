import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/nutrition_usecase.dart';

import '../../../domain/entities/nutrition_entity.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  final Map<String, NutritionEntity> mapNutritions = {};
  final NutritionUseCase nutritionUseCase;
  NutritionCubit({required this.nutritionUseCase}) : super(const NutritionInitial());

  Future<void> fetchNutritionByProductId(String foodId) async {
    emit(const NutritionLoading());
    if (mapNutritions.containsKey(foodId)) {
      emit(NutritionData(mapNutritions[foodId]!));
    } else {
      await nutritionUseCase.call(params: foodId).then(
        (value) {
          value.fold(
            (error) {
              emit(NutritionError(error));
            },
            (nutrition) {
              emit(NutritionData(nutrition));
            },
          );
        },
      );
    }
  }
}
