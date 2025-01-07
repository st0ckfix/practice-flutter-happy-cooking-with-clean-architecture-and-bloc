class ProductEntity {
  final String productId;
  final String productLabel;
  final String productType;
  final String productThumbnail;
  final String productDescription;
  final String productProviderId;
  final String productNutritionId;
  final List<ProductOption> productOptions;
  final double productDiscount;
  final List<String> productTags;
  final double productRatingAverage;
  final int productInStock;
  final int productSold;

  ProductEntity({
    required this.productId,
    required this.productLabel,
    required this.productType,
    required this.productOptions,
    required this.productThumbnail,
    required this.productRatingAverage,
    required this.productDescription,
    required this.productProviderId,
    required this.productNutritionId,
    this.productDiscount = .0,
    required this.productTags,
    required this.productInStock,
    required this.productSold,
  });

  double getDiscountValue(int select) {
    return getOption(select).cost * productDiscount;
  }

  double getTotalValue(int select) {
    return getOption(select).cost - getDiscountValue(select);
  }

  bool get hasDiscount {
    return productDiscount != .0;
  }

  String get getDiscountLabel {
    return '-${(productDiscount * 100).toStringAsFixed(0)}%';
  }

  ProductOption getOption(int select) {
    return productOptions[select];
  }

  @override
  String toString() {
    return '[productId]-$productId, [productType]-$productType, [productLabel]-$productLabel, [productTags]-$productTags';
  }
}

class ProductOption {
  final String title;
  final String? subtitle;
  final String? image;
  final double cost;

  ProductOption({
    required this.title,
    required this.cost,
    this.subtitle,
    this.image,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(
      title: json['title'],
      cost: json['cost'] + .0,
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['cost'] = cost;
    if (subtitle != null) {
      map['subtitle'] = subtitle;
    }
    if (image != null) {
      map['image'] = image;
    }
    return map;
  }

  @override
  String toString() {
    return '[title]-$title, [cost]-$cost';
  }
}
