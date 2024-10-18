import '../../domain/entities/app_coupon_entity.dart';

class AppCouponModel extends AppCouponEntity {
  AppCouponModel({
    required super.id,
    required super.lable,
    required super.title,
    required super.subtitle,
    required super.appCouponType,
    required super.discountCouponType,
    required super.conditionValue,
    required super.discountValue,
    required super.maxDiscountValue,
    required super.expiredDate,
    super.image,
  });

  factory AppCouponModel.fromJson(Map<String, dynamic> map) {
    return AppCouponModel(
      id: map['id'],
      lable: map['label'],
      title: map['title'],
      subtitle: map['subtitle'],
      appCouponType: map['appCouponType'],
      discountCouponType: map['discountCouponType'],
      conditionValue: map['conditionValue'],
      discountValue: map['discountValue'],
      maxDiscountValue: map['maxDisccountValue'],
      expiredDate: map['expiredDate'],
      image: map['image'],
    );
  }
}
