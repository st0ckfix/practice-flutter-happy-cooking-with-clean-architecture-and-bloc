import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/nutrition_entity.dart';

abstract class NutritionRepository<T> {
  Future<Either<String, NutritionEntity>> getNutritions(String productId);
}
