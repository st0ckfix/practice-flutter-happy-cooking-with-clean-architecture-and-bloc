import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/coupon_repositery.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/coupon_model.dart';

class CouponUseCase extends UseCase<Either<String, List<CouponModel>>, void> {
  final CouponRepository appCouponRepository;
  CouponUseCase({required this.appCouponRepository});

  @override
  Future<Either<String, List<CouponModel>>> call({void params}) {
    return appCouponRepository.getCoupon();
  }
}
