import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';

import '../../domain/entities/recipe_entity.dart';

class RecipeSelectCubit extends Cubit<RecipeEntity?> {
  final ProductCubit productCubit;
  RecipeSelectCubit({required this.productCubit}) : super(null);

  void addRecipe({required RecipeEntity recipe}) {
    if (recipe.recipeId == state?.recipeId) return;
    emit(recipe);
  }

  void clearRecipe() {
    emit(null);
  }
}
