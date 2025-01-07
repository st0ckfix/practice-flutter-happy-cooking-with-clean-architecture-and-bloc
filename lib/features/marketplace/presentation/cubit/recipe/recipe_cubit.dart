import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/recipe_usecase.dart';

part 'recipe_state.dart';

class AllRecipeCubit extends Cubit<RecipeState> {
  final Map<String, List<String>> listRecipesByRecipeType = {};
  final Map<String, List<String>> listRecipesByRecipeTag = {};
  final Map<String, List<String>> listRecipesByFoodType = {};
  final Map<String, List<String>> listRecipesByFoodTag = {};
  List<String>? listRecipesId;
  final RecipeUseCase recipeUseCase;
  AllRecipeCubit({required this.recipeUseCase}) : super(RecipeInitial()) {
    fetchListRecipe;
  }

  Future<void> get fetchListRecipe async {
    await recipeUseCase.call().then((value) {
      value.fold(
        (error) {
          emit(RecipeError(error));
        },
        (mapRecipes) {
          emit(RecipeData(mapRecipes));
        },
      );
    });
  }

  List<String>? setListRecipesType({required String recipeType}) {
    final sortedList = state.mapRecipes!.values
        .where(
          (element) => element.recipeType == recipeType,
        )
        .toList()
      ..sort(
        (a, b) => b.recipeLikes.length.compareTo(a.recipeLikes.length),
      );

    final finalList = sortedList
        .map(
          (e) => e.recipeId,
        )
        .toList();

    listRecipesByRecipeType[recipeType] = finalList;
    return finalList;
  }

  List<String>? getListRecipesByRecipeType({required String recipeType}) {
    return listRecipesByRecipeType[recipeType] ?? setListRecipesType(recipeType: recipeType);
  }

  List<String>? setListRecipesTag({required String recipeTag}) {
    final sortedList = state.mapRecipes!.values
        .where(
          (element) => element.recipeTags.contains(recipeTag),
        )
        .toList()
      ..sort(
        (a, b) => b.recipeLikes.length.compareTo(a.recipeLikes.length),
      );

    final finalList = sortedList
        .map(
          (e) => e.recipeId,
        )
        .toList();

    listRecipesByRecipeType[recipeTag] = finalList;
    return finalList;
  }

  List<String>? getListRecipesByRecipeTag({required String recipeTag}) {
    return listRecipesByRecipeType[recipeTag] ?? setListRecipesTag(recipeTag: recipeTag);
  }

  List<String>? setListRecipesFoodType({required String foodType}) {
    final sortedList = state.mapRecipes!.values
        .where(
          (element) => element.getListIngredientsId.contains(foodType),
        )
        .toList()
      ..sort(
        (a, b) => b.recipeLikes.length.compareTo(a.recipeLikes.length),
      );

    final finalList = sortedList
        .map(
          (e) => e.recipeId,
        )
        .toList();

    listRecipesByFoodType[foodType] = finalList;
    return finalList;
  }

  List<String>? getListRecipesByFoodType({required String foodType}) {
    return listRecipesByFoodType[foodType] ?? setListRecipesFoodType(foodType: foodType);
  }

  RecipeEntity? getRecipeByRecipeId({required String recipeId}) {
    return state.mapRecipes![recipeId];
  }

  List<RecipeEntity> get getMyRecipes {
    return state.mapRecipes!.values.toList()
      ..shuffle()
      ..sublist(0, 5);
  }

  List<RecipeEntity> get getTopRecipes {
    return state.mapRecipes!.values.toList()
      ..shuffle()
      ..sublist(0, 5);
  }
}
