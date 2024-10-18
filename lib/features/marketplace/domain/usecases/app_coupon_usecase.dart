import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/app_coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/app_coupon_repositery.dart';

import '../../../../core/usecases/usecase.dart';

class AppCouponUseCase extends UseCase<Either<String, List<AppCouponEntity>>, void> {
  final AppCouponRepository appCouponRepository;
  AppCouponUseCase(this.appCouponRepository);

  @override
  Future<Either<String, List<AppCouponEntity>>> call({void params}) {
    return appCouponRepository.getAppCoupon();
  }
}
