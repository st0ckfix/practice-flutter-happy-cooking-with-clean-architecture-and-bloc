import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/recipe_repository.dart';

class RecipeUseCase extends UseCase<Either<String, Map<String, RecipeEntity>>, void> {
  final RecipeRepository recipeRepository;
  RecipeUseCase({required this.recipeRepository});

  @override
  Future<Either<String, Map<String, RecipeEntity>>> call({void params}) {
    return recipeRepository.getRecipes();
  }
}
