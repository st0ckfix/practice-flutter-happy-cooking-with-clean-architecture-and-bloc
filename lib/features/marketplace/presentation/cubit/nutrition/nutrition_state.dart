part of 'nutrition_cubit.dart';

abstract class NutritionState extends Equatable {
  final NutritionEntity? nutritionEntity;
  final String? error;
  const NutritionState({this.nutritionEntity, this.error});

  @override
  List<Object> get props => [nutritionEntity!, error!];
}

final class NutritionInitial extends NutritionState {
  const NutritionInitial() : super();
}

final class NutritionLoading extends NutritionState {
  const NutritionLoading() : super();
}

final class NutritionData extends NutritionState {
  const NutritionData(NutritionEntity nutritionEntity) : super(nutritionEntity: nutritionEntity);
}

final class NutritionError extends NutritionState {
  const NutritionError(String error) : super(error: error);
}
