import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/app_coupon_entity.dart';

import '../../../../core/datasource/firestore_service.dart';
import '../../domain/repositories/app_coupon_repositery.dart';
import '../models/app_coupon_model.dart';

class AppCouponRepositoryImpl extends AppCouponRepository {
  final ReadListFireStore readListFireStore;
  AppCouponRepositoryImpl(this.readListFireStore);
  @override
  Future<Either<String, List<AppCouponModel>>> getAppCoupon() async {
    // final data = await readListFireStore.readDocument(params: 'AppCoupon');
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => AppCouponModel.fromJson(e.data()!)).toList());
    return Right(await fetchListCate());
  }
}

Future<List<AppCouponModel>> fetchListCate() async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    AppCouponModel(
      id: 'id1',
      lable: 'B190D10',
      title: 'Discount 10%, up to 50\$',
      subtitle: 'For purchasing bill more than 190\$',
      appCouponType: AppCouponType.total,
      discountCouponType: DiscountCouponType.percent,
      conditionValue: 190,
      discountValue: .1,
      maxDiscountValue: 50,
      expiredDate: DateTime.utc(2024, DateTime.december, 12),
    ),
    AppCouponModel(
      id: 'id2',
      lable: 'B500D15',
      title: 'Discount 15%, up to 200\$',
      subtitle: 'For purchasing bill more than 500\$',
      appCouponType: AppCouponType.total,
      discountCouponType: DiscountCouponType.percent,
      conditionValue: 500,
      discountValue: .15,
      maxDiscountValue: 200,
      expiredDate: DateTime.utc(2024, DateTime.december, 12),
    ),
    AppCouponModel(
      id: 'id3',
      lable: 'B12D01',
      title: 'Discount 1\$ shipping',
      subtitle: 'For purchasing bill more than 12\$',
      appCouponType: AppCouponType.delivery,
      discountCouponType: DiscountCouponType.exact,
      conditionValue: 12,
      discountValue: 1,
      maxDiscountValue: 1,
      expiredDate: DateTime.utc(2024, DateTime.november, 11),
    ),
    AppCouponModel(
      id: 'id4',
      lable: 'B25D02',
      title: 'Discount 2\$',
      subtitle: 'For purchasing bill more than 25\$',
      appCouponType: AppCouponType.delivery,
      discountCouponType: DiscountCouponType.exact,
      conditionValue: 25,
      discountValue: 2,
      maxDiscountValue: 2,
      expiredDate: DateTime.utc(2024, DateTime.november, 11),
    ),
  ];
}
