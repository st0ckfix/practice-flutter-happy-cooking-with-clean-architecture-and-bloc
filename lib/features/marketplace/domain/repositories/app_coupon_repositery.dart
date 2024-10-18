import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/app_coupon_entity.dart';

abstract class AppCouponRepository<T> {
  Future<Either<String, List<AppCouponEntity>>> getAppCoupon();
}
