part of 'recipe_cubit.dart';

abstract class RecipeState extends Equatable {
  final Map<String, RecipeEntity>? mapRecipes;
  final String? error;
  const RecipeState({this.mapRecipes, this.error});

  @override
  List<Object> get props => [mapRecipes!, error!];
}

final class RecipeInitial extends RecipeState {
  RecipeInitial() : super(mapRecipes: {});
}

final class RecipeLoading extends RecipeState {
  const RecipeLoading() : super();
}

final class RecipeData extends RecipeState {
  const RecipeData(Map<String, RecipeEntity> mapRecipes) : super(mapRecipes: mapRecipes);
}

final class RecipeError extends RecipeState {
  const RecipeError(String error) : super(error: error);
}
