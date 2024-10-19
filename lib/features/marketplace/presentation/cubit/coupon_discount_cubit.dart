import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/coupon_entity.dart';

abstract class CouponDiscountValue<T> extends Cubit<T> {
  CouponDiscountValue(super.initialState);
}

class CouponProductDiscountCubit extends CouponDiscountValue<CouponProductEntity?> {
  CouponProductDiscountCubit() : super(null);
  void updateCoupon(CouponProductEntity? newCoupon) {
    if (state?.couponId == newCoupon?.couponId) {
      return;
    }
    emit(newCoupon);
  }
}

class CouponDeliveryDiscountCubit extends CouponDiscountValue<CouponDeliveryEntity?> {
  CouponDeliveryDiscountCubit() : super(null);
  void updateCoupon(CouponDeliveryEntity? newCoupon) {
    if (state?.couponId == newCoupon?.couponId) {
      return;
    }
    emit(newCoupon);
  }
}
