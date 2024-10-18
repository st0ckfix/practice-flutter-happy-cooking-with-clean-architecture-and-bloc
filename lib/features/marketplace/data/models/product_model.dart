import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({required super.id, required super.label, required super.image, required super.tags});

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(id: map['id'], label: map['label'], image: map['image'], tags: map['tags']);
  }
}
