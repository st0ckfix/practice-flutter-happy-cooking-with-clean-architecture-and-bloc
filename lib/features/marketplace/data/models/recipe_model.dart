import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel({
    required super.recipeId,
    required super.recipeTitle,
    required super.recipeType,
    required super.recipeDescription,
    required super.recipeServingSize,
    required super.recipePrepTime,
    required super.recipeCookTime,
    required super.recipeSteps,
    required super.recipeImage,
    required super.recipeLikes,
    required super.recipeTags,
    super.recipeTips,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> map) {
    return RecipeModel(
      recipeId: map['recipeId'],
      recipeTitle: map['recipeTitle'],
      recipeType: map['recipeType'],
      recipeImage: map['recipeImage'],
      recipeDescription: map['recipeDescription'],
      recipeServingSize: map['recipeServingSize'],
      recipePrepTime: parseDuration(map['recipePrepTime']),
      recipeCookTime: parseDuration(map['recipeCookTime']),
      recipeSteps: (map['recipeSteps'] as List).map((e) => CookingStep.fromJson(e)).toList(),
      recipeLikes: (map['recipeLikes'] as List).cast(),
      recipeTags: (map['recipeTags'] as List).cast(),
      recipeTips: map['recipeTips'],
    );
  }

  Map<String, dynamic> toJson() {
    final steps = recipeSteps.map((e) => e.toJson()).toList();
    return {
      'recipeId': recipeId,
      'recipeImage': recipeImage,
      'recipeTitle': recipeTitle,
      'recipeType': recipeType,
      'recipeDescription': recipeDescription,
      'recipeServingSize': recipeServingSize,
      'recipePrepTime': recipePrepTime.toString(),
      'recipeCookTime': recipeCookTime.toString(),
      'recipeSteps': steps,
      'recipeLikes': recipeLikes,
      'recipeTags': recipeTags,
    };
  }
}
