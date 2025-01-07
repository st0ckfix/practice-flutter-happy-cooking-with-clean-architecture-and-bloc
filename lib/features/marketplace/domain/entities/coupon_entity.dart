import 'dart:math';

/// Type of coupon
enum CouponType {
  /// Flat value discount
  flatDiscount,

  /// Percent value discount
  percentageDiscount,
}

enum CouponApplyType {
  /// Apply for delivery cost
  delivery,

  /// Apply for product cost, include product sale
  product,
}

class CouponEntity {
  /// Coupon Id
  final String id;

  /// Coupon Label 'FREESHIP20'
  final String label;

  /// Coupon Title 'Discount 20%'
  final String title;

  /// Coupon Subtitle 'Max 5$ For 100$ Bill'
  final String subtitle;

  /// Coupon Discount
  final double valueDiscount;

  /// Coupon Max Discount, [null] For No Limit
  final double? maxDiscount;

  /// Type of Coupon Discount
  final CouponType couponType;

  /// Type of Applying
  final CouponApplyType applyType;

  /// Coupon Discount Condition
  final Condition? condition;

  /// Coupon Valid
  final DateTime? validUntil;

  CouponEntity({
    required this.id,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.valueDiscount,
    this.maxDiscount,
    required this.couponType,
    required this.applyType,
    this.condition,
    this.validUntil,
  });

  String discountValueLabel() {
    return couponType == CouponType.percentageDiscount ? (valueDiscount * 100).toStringAsFixed(0) : valueDiscount.toStringAsFixed(2);
  }

  double discountValue(double orderValue) {
    return couponType == CouponType.flatDiscount ? valueDiscount : min(maxDiscount ?? 1000000.0, valueDiscount * orderValue);
  }

  bool isPercentage() {
    return couponType == CouponType.percentageDiscount;
  }

  bool isValid() {
    return DateTime.now().millisecondsSinceEpoch >= (validUntil?.millisecondsSinceEpoch ?? DateTime(3000, 1, 1).millisecondsSinceEpoch);
  }

  @override
  String toString() {
    return 'Coupon {id: $id, label: $label, title: $title, subtitle: $subtitle, maxDiscount: ${maxDiscount ?? 'No limit'}, couponType: $couponType, applyType: $applyType, validUntil: ${validUntil?.toIso8601String() ?? 'No expiration'}}';
  }
}

class Condition {
  /// Minimum value to apply coupon
  final double? minOrderValue;

  /// Minimem product order to apply coupon
  final int? minItems;

  /// Is only apply for first time use
  final bool? firstTimeUser;

  Condition({
    this.minOrderValue,
    this.minItems,
    this.firstTimeUser,
  });

  bool isSatisfied({double orderValue = .0, int items = 0, bool isFirstTimeUser = true}) {
    if (minOrderValue != null && orderValue < minOrderValue!) return false;
    if (minItems != null && items < minItems!) return false;
    if (firstTimeUser != null && firstTimeUser! && !isFirstTimeUser) return false;
    return true;
  }

  @override
  String toString() {
    return 'Condition {minOrderValue: $minOrderValue, minItems: $minItems, firstTimeUser: $firstTimeUser}';
  }
}
