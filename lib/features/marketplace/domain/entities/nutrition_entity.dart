enum NutriType { calo, lipid, cholesterol, na, ka, ca, fe, mg, vitaC, vitaD, vitaB6, vitaB12, carbohydrat, protein }

extension NutriExtension on NutriType {
  String label() {
    switch (this) {
      case NutriType.calo:
        return 'Calories';
      case NutriType.lipid:
        return 'Lipids';
      case NutriType.cholesterol:
        return 'Cholesterol';
      case NutriType.na:
        return 'Sodium';
      case NutriType.ka:
        return 'Kali';
      case NutriType.ca:
        return 'Calci';
      case NutriType.fe:
        return 'Iron';
      case NutriType.mg:
        return 'Magnesium';
      case NutriType.vitaC:
        return 'Vitamin C';
      case NutriType.vitaD:
        return 'Vitamin D';
      case NutriType.vitaB6:
        return 'Vitamin B6';
      case NutriType.vitaB12:
        return 'Vitamin B12';
      case NutriType.carbohydrat:
        return 'Carbonhydrates';
      case NutriType.protein:
        return 'Proteins';
    }
  }

  String unit() {
    switch (this) {
      case NutriType.calo:
        return 'kcal';
      case NutriType.lipid:
        return 'g';
      case NutriType.cholesterol:
        return 'mg';
      case NutriType.na:
        return 'mg';
      case NutriType.ka:
        return 'mg';
      case NutriType.ca:
        return 'mg';
      case NutriType.fe:
        return 'mg';
      case NutriType.mg:
        return 'mg';
      case NutriType.vitaC:
        return 'mg';
      case NutriType.vitaD:
        return 'mg';
      case NutriType.vitaB6:
        return 'mg';
      case NutriType.vitaB12:
        return 'mg';
      case NutriType.carbohydrat:
        return 'g';
      case NutriType.protein:
        return 'g';
    }
  }
}

class NutritionEntity {
  final String nutritionId;
  final String productId;
  final Map<NutriType, double> nutritionValue;

  NutritionEntity({
    required this.nutritionId,
    required this.productId,
    required this.nutritionValue,
  });

  @override
  String toString() {
    return '[nutritionId]-$nutritionId, [productId]-$productId';
  }
}
