import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';

class CategoryDetailModel extends CategoryDetailEntity {
  CategoryDetailModel({required super.id, required super.label, required super.image});

  factory CategoryDetailModel.fromJson(Map<String, dynamic> map) {
    return CategoryDetailModel(id: map['id'], label: map['label'], image: map['image']);
  }
}
