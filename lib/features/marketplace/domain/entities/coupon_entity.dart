abstract class CouponEntity {
  final String couponId;
  final String couponLable;
  final String? couponDescription;
  final double? couponCondition;
  final bool? couponIsPercentValue;
  final double couponValue;
  final double? couponMaxValue;
  final DateTime? couponExpired;

  CouponEntity({
    required this.couponId,
    required this.couponLable,
    required this.couponValue,
    this.couponDescription,
    this.couponCondition,
    this.couponIsPercentValue,
    this.couponMaxValue,
    this.couponExpired,
  });
}

class CouponProductEntity extends CouponEntity {
  CouponProductEntity({
    required super.couponId,
    required super.couponLable,
    required super.couponCondition,
    required super.couponIsPercentValue,
    required super.couponValue,
    super.couponDescription,
    super.couponExpired,
    super.couponMaxValue,
  });
}

class CouponDeliveryEntity extends CouponEntity {
  CouponDeliveryEntity({
    required super.couponId,
    required super.couponLable,
    required super.couponCondition,
    required super.couponValue,
    super.couponDescription,
    super.couponExpired,
  });
}
