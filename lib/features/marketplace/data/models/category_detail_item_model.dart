import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_item_entity.dart';

class CategoryDetailItemModel extends CategoryDetailItemEntity {
  const CategoryDetailItemModel({required super.id, required super.label, required super.image});

  factory CategoryDetailItemModel.fromJson(Map<String, dynamic> map) {
    return CategoryDetailItemModel(id: map['id'], label: map['label'], image: map['image']);
  }
}
