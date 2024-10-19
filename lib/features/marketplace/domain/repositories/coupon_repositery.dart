import 'package:dartz/dartz.dart';

import '../../data/models/coupon_model.dart';

abstract class CouponRepository<T> {
  Future<Either<String, (List<CouponDeliveryModel>, List<CouponProductModel>)>> getCoupon();
}
