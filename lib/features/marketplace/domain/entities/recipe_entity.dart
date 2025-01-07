Duration parseDuration(String durationString) {
  final parts = durationString.split(':');
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);
  final seconds = double.parse(parts[2]).toInt();

  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}

class RecipeEntity {
  final String recipeId;
  final String recipeImage;
  final String recipeTitle;
  final String recipeType;
  final String recipeDescription;
  final int recipeServingSize;
  final Duration recipePrepTime;
  final Duration recipeCookTime;
  final List<String> recipeLikes;
  final List<CookingStep> recipeSteps;
  final List<String> recipeTags;
  final List<String>? recipeTips;

  RecipeEntity({
    required this.recipeId,
    required this.recipeImage,
    required this.recipeTitle,
    required this.recipeType,
    required this.recipeDescription,
    required this.recipeServingSize,
    required this.recipePrepTime,
    required this.recipeCookTime,
    required this.recipeSteps,
    required this.recipeLikes,
    required this.recipeTags,
    this.recipeTips,
  });

  String getDurationLabel(Duration duration) {
    final totalSecond = duration.inSeconds;
    final hours = totalSecond / 3600;
    final minutes = (totalSecond % 3600) / 60;
    final seconds = (totalSecond % 3600) % 60;
    return '${hours}h${minutes}m${seconds}s';
  }

  String get getPrepareTimeLabel {
    return getDurationLabel(recipePrepTime);
  }

  String get getCookingTimeLabel {
    return getDurationLabel(recipeCookTime);
  }

  List<Ingredient> get getListIngredients {
    return recipeSteps
        .where((step) => step.ingredient != null)
        .map((e) => e.ingredient!)
        .expand(
          (e) => e,
        )
        .toList();
  }

  List<String> get getListIngredientsId {
    return getListIngredients
        .map(
          (e) => e.ingredientId,
        )
        .toList();
  }

  @override
  String toString() {
    return '[recipeId]-$recipeId, [recipeTitle]-$recipeTitle, [recipeTags]-$recipeTags';
  }
}


class CookingStep {
  final int stepNumber;
  final String instruction;
  final Duration duration;
  final List<String>? images;
  final List<Ingredient>? ingredient;
  final List<Ingredient>? addOn;

  CookingStep({
    required this.stepNumber,
    required this.instruction,
    required this.duration,
    this.images,
    this.ingredient,
    this.addOn,
  });

  factory CookingStep.fromJson(Map<String, dynamic> json) {
    return CookingStep(
      stepNumber: json['stepNumber'],
      instruction: json['instruction'],
      duration: parseDuration( json['duration']),
      ingredient: json['ingredient'] != null ? (json['ingredient'] as List<dynamic>).map((e) => Ingredient.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final ingre = ingredient?.map((e) => e.toJson()).toList();
    return {
      'stepNumber': stepNumber,
      'instruction': instruction,
      'duration': duration.toString(),
      if (ingre != null) 'ingredient': ingre,
    };
  }
}

class Ingredient {
  final String ingredientId;
  final double quantity;
  final String unit;
  final String state;

  Ingredient({
    required this.ingredientId,
    required this.quantity,
    required this.unit,
    required this.state,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientId: json['ingredientId'],
      quantity: json['quantity'] + .0,
      unit: json['unit'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'quantity': quantity,
      'unit': unit,
      'state': state,
    };
  }
}
