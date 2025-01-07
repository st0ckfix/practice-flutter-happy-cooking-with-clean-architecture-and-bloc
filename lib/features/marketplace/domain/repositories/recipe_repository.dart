import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';

abstract class RecipeRepository<T> {
  Future<Either<String, Map<String, RecipeEntity>>> getRecipes();
}
