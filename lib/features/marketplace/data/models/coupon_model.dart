import 'dart:math';

import '../../domain/entities/coupon_entity.dart';

class CouponProductModel extends CouponProductEntity {
  CouponProductModel({
    required super.couponId,
    required super.couponLable,
    required super.couponCondition,
    required super.couponIsPercentValue,
    required super.couponValue,
    super.couponDescription,
    super.couponExpired,
    super.couponMaxValue,
  });

  factory CouponProductModel.fromJson(Map<String, dynamic> map) {
    return CouponProductModel(
      couponId: map['couponProductId'],
      couponLable: map['couponProductLable'],
      couponCondition: map['couponProductCondition'],
      couponIsPercentValue: map['couponProductIsPercentValue'],
      couponValue: map['couponProductValue'],
      couponDescription: map['couponProductDescription'],
      couponExpired: map['couponProductExpired'],
      couponMaxValue: map['couponProductMaxValue'],
    );
  }

  factory CouponProductModel.sample(int? pos) {
    final couponId = Random().nextInt(1000000).toString();
    final couponLable = ['HAPPYDISC', 'NEWBIES', 'FRIEND', 'ICANCOOK', 'YUMMY2'][pos ?? Random().nextInt(5)];
    final couponCondition = [.0, 30.0, 50.0, 100.0, 150.0, 200.0][pos ?? Random().nextInt(6)];
    final couponIsPercentValue = Random().nextBool();
    final couponValue = couponIsPercentValue ? [.1, .15, .2, .25, .3][Random().nextInt(5)] : [.5, 1.0, 1.5, 2.5, 3.0][Random().nextInt(5)];
    final couponDescription = Random().nextBool() ? 'This is Product Discount Description' : null;
    final couponMaxValue = couponIsPercentValue ? [20.0, 25.0, 30.0, 35.0, 50.0][Random().nextInt(5)] : null;
    return CouponProductModel(
      couponId: couponId,
      couponLable: couponLable,
      couponCondition: couponCondition,
      couponIsPercentValue: couponIsPercentValue,
      couponValue: couponValue,
      couponDescription: couponDescription,
      couponMaxValue: couponMaxValue,
    );
  }
}

class CouponDeliveryModel extends CouponDeliveryEntity {
  CouponDeliveryModel({
    required super.couponId,
    required super.couponLable,
    required super.couponCondition,
    required super.couponValue,
    super.couponDescription,
    super.couponExpired,
  });

  factory CouponDeliveryModel.fromJson(Map<String, dynamic> map) {
    return CouponDeliveryModel(
      couponId: map['couponDeliveryId'],
      couponLable: map['couponDeliveryLable'],
      couponCondition: map['couponDeliveryCondition'],
      couponValue: map['couponDeliveryValue'],
      couponDescription: map['couponDeliveryDescription'],
      couponExpired: map['couponDeliveryExpired'],
    );
  }

  factory CouponDeliveryModel.sample(int? pos) {
    final couponId = Random().nextInt(1000000).toString();
    final couponLable = ['FREESHIP1', 'DISCOUN1', 'DELIVERY1'][pos ?? Random().nextInt(3)];
    final couponCondition = [.0, 10.0, 30.0, 50.0][pos ?? Random().nextInt(4)];
    final couponValue = [.5, 1.0, 1.5][Random().nextInt(3)];
    final couponDescription = Random().nextBool() ? 'This is Delivery Discount Description' : null;
    return CouponDeliveryModel(
      couponId: couponId,
      couponLable: couponLable,
      couponCondition: couponCondition,
      couponValue: couponValue,
      couponDescription: couponDescription,
    );
  }
}
