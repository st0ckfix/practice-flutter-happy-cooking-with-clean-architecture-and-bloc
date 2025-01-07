import 'dart:math';

import '../../domain/entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  CouponModel({
    required super.id,
    required super.label,
    required super.title,
    required super.subtitle,
    required super.valueDiscount,
    required super.couponType,
    required super.applyType,
    super.condition,
    super.maxDiscount,
    super.validUntil,
  });

  factory CouponModel.fromJson(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id'],
      label: map['label'],
      title: map['title'],
      subtitle: map['subtitle'],
      valueDiscount: map['valueDiscount'],
      couponType: map['couponType'],
      applyType: map['applyType'],
      condition: map['condition'],
      maxDiscount: map['maxDiscount'],
      validUntil: map['validUntil'],
    );
  }

  factory CouponModel.flatSample(int pos, String labels, CouponType type) {
    final id = Random().nextInt(1000000).toString();
    final label = '$labels$pos';
    final conditionValue = pos * 10.0 + 10.0;
    final valueDiscount = pos * 0.5 + 0.5;
    final title = '${valueDiscount.toStringAsFixed(1)}${type == CouponType.flatDiscount ? '\$' : '%'} Discount';
    final subtitle = 'Apply For ${conditionValue.toStringAsFixed(1)}\$ Bill';
    final condition = Condition(minOrderValue: conditionValue);
    final validUntil = DateTime.now().copyWith(month: DateTime.september, day: pos);
    return CouponModel(
      id: id,
      label: label,
      title: title,
      subtitle: subtitle,
      valueDiscount: valueDiscount,
      couponType: CouponType.flatDiscount,
      applyType: CouponApplyType.product,
      condition: condition,
      validUntil: validUntil,
    );
  }
}
