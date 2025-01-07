import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';

import '../../../../core/datasource/firestore_service.dart';
import '../../domain/repositories/coupon_repositery.dart';
import '../models/coupon_model.dart';

class CouponRepositoryImpl extends CouponRepository {
  final ReadListFireStore readListFireStore;
  CouponRepositoryImpl({required this.readListFireStore});
  @override
  Future<Either<String, List<CouponModel>>> getCoupon() async {
    // final data = await readListFireStore.readDocument(params: 'AppCoupon');
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => AppCouponModel.fromJson(e.data()!)).toList());
    return Right(await fetchListCate());
  }
}

Future<List<CouponModel>> fetchListCate() async {
  await Future.delayed(const Duration(seconds: 2));
  return List.generate(10, (index) => CouponModel.flatSample(index, 'HAPPY', CouponType.flatDiscount))
    ..addAll(
      List.generate(10, (index) => CouponModel.flatSample(index, 'COOK', CouponType.percentageDiscount)),
    );
}
