import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.productId,
    required super.productLabel,
    required super.productType,
    required super.productOptions,
    required super.productThumbnail,
    required super.productRatingAverage,
    required super.productDescription,
    required super.productProviderId,
    required super.productNutritionId,
    super.productDiscount = .0,
    required super.productTags,
    required super.productInStock,
    required super.productSold,
  });

  ProductModel copyWith({
    required String productProviderId,
  }) {
    return ProductModel(
      productId: productId,
      productLabel: productLabel,
      productType: productType,
      productOptions: productOptions,
      productThumbnail: productThumbnail,
      productRatingAverage: productRatingAverage,
      productDescription: productDescription,
      productProviderId: productProviderId ,
      productNutritionId: productNutritionId,
      productTags: productTags,
      productInStock: productInStock,
      productSold: productSold,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      productLabel: json['productLabel'],
      productType: json['productType'],
      productThumbnail: json['productThumbnail'],
      productRatingAverage: json['productRatingAverage'] + .0,
      productDescription: json['productDescription'],
      productOptions: (json['productOptions'] as List).map((e) => ProductOption.fromJson(e)).toList(),
      productDiscount: json['productDiscount'] + .0,
      productTags: (json['productTags'] as List).cast(),
      productProviderId: json['productProviderId'],
      productNutritionId: json['productNutritionId'],
      productInStock: json['productInStock'],
      productSold: json['productSold'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': super.productId,
      'productLabel': super.productLabel,
      'productType': super.productType,
      'productOptions': super.productOptions.map((e) => e.toJson()).toList(),
      'productThumbnail': super.productThumbnail,
      'productRatingAverage': super.productRatingAverage,
      'productDescription': super.productDescription,
      'productProviderId': super.productProviderId,
      'productNutritionId': 'nutri-${super.productId}',
      'productDiscount': super.productDiscount,
      'productTags': super.productTags,
      'productInStock': super.productInStock,
      'productSold': super.productSold,
    };
  }
}
