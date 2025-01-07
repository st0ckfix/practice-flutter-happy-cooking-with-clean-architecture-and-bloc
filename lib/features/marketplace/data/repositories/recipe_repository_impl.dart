import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/recipe_repository.dart';

import '../../../../core/datasource/firestore_service.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  final ReadListFireStore readListFireStore;
  RecipeRepositoryImpl({required this.readListFireStore});

  @override
  Future<Either<String, Map<String, RecipeModel>>> getRecipes() async {
    return fetchRecipes();
  }
}

Future<Either<String, Map<String, RecipeModel>>> fetchRecipes() async {
  try {
    final String jsonString = await rootBundle.loadString('assets/file/recipes.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return Right(
      jsonData.map(
        (key, value) => MapEntry(key, RecipeModel.fromJson(value)),
      ),
    );
  } catch (e) {
    print(e.toString());
    return Left(e.toString());
  }
}
