import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/coupon_repositery.dart';

import '../../../../core/usecases/usecase.dart';

class CouponUseCase extends UseCase<Either<String, (List<CouponDeliveryEntity>, List<CouponProductEntity>)>, void> {
  final CouponRepository appCouponRepository;
  CouponUseCase(this.appCouponRepository);

  @override
  Future<Either<String, (List<CouponDeliveryEntity>, List<CouponProductEntity>)>> call({void params}) {
    return appCouponRepository.getCoupon();
  }
}
