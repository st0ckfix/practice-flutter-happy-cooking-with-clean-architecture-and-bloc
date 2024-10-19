import 'package:dartz/dartz.dart';

import '../../../../core/datasource/firestore_service.dart';
import '../../domain/repositories/coupon_repositery.dart';
import '../models/coupon_model.dart';

class CouponRepositoryImpl extends CouponRepository {
  final ReadListFireStore readListFireStore;
  CouponRepositoryImpl(this.readListFireStore);
  @override
  Future<Either<String, (List<CouponDeliveryModel>, List<CouponProductModel>)>> getCoupon() async {
    // final data = await readListFireStore.readDocument(params: 'AppCoupon');
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => AppCouponModel.fromJson(e.data()!)).toList());
    return Right(await fetchListCate());
  }
}

Future<(List<CouponDeliveryModel>, List<CouponProductModel>)> fetchListCate() async {
  await Future.delayed(const Duration(seconds: 2));
  return (
    [
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
      CouponDeliveryModel.sample(null),
    ],
    [
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
      CouponProductModel.sample(null),
    ]
  );
}
