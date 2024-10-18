enum AppCouponType {
  delivery,
  total,
}

enum DiscountCouponType {
  exact,
  percent,
}

class AppCouponEntity {
  final String id;
  final String lable;
  final String title;
  final String subtitle;
  final String? image;
  final AppCouponType appCouponType;
  final DiscountCouponType discountCouponType;
  final double conditionValue;
  final double discountValue;
  final double maxDiscountValue;
  final DateTime expiredDate;

  AppCouponEntity({
    required this.id,
    required this.lable,
    required this.title,
    required this.subtitle,
    this.image,
    required this.appCouponType,
    required this.discountCouponType,
    required this.conditionValue,
    required this.discountValue,
    required this.maxDiscountValue,
    required this.expiredDate,
  });
}
