import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/nutrition_entity.dart';
import '../repositories/nutrition_repository.dart';

class NutritionUseCase extends UseCase<Either<String, NutritionEntity>, String> {
  final NutritionRepository nutritionRepository;
  NutritionUseCase({required this.nutritionRepository});
  
  @override
  Future<Either<String, NutritionEntity>> call({String? params}) {
    return nutritionRepository.getNutritions(params!);
  }
}
