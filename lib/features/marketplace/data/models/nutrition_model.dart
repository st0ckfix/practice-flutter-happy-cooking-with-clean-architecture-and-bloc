
import '../../domain/entities/nutrition_entity.dart';

final nutriTypeMap = {for (var e in NutriType.values) e.name: e};

class NutritionModel extends NutritionEntity {
  NutritionModel({
    required super.nutritionId,
    required super.productId,
    required super.nutritionValue,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> map) {
    return NutritionModel(
      nutritionId: map['nutritionId'],
      productId: map['productId'],
      nutritionValue: (map['nutritionValue'] as Map).cast().map((key, value) => MapEntry(nutriTypeMap[key]!, value + .0)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nutritionId': nutritionId,
      'productId': productId,
      'nutritionValue': nutritionValue.map((key, value) => MapEntry(key.name, value)),
    };
  }
}