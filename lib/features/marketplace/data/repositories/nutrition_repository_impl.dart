import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/nutrition_entity.dart';

import '../../../../core/datasource/firestore_service.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../models/nutrition_model.dart';

class NutritionRepositoryImpl extends NutritionRepository {
  final ReadListFireStore readListFireStore;
  NutritionRepositoryImpl({required this.readListFireStore});

  @override
  Future<Either<String, NutritionEntity>> getNutritions(String productId) {
    return fetchNutritions(productId);
  }
}

Future<Either<String, NutritionModel>> fetchNutritions(String productId) async {
  try {
    final String jsonString = await rootBundle.loadString('assets/file/product_nutri.json');
    final data = (jsonDecode(jsonString) as Map<String, dynamic>)[productId];
    return Right(NutritionModel.fromJson(data));
  } catch (e) {
    print(e.toString());
    return Left(e.toString());
  }
}
