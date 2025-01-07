import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/data/models/banner_model.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/banner_repository.dart';

import '../../../../core/datasource/firestore_service.dart';

class BannerRepositoryImpl extends BannerRepository {
  final ReadListFireStore readListFireStore;
  BannerRepositoryImpl({required this.readListFireStore});
  @override
  Future<Either<String, Map<String, BannerModel>>> getBanner() async {
    // final data = await readListFireStore.readDocument(params: 'AppCoupon');
    // if (data.isEmpty) {
    //   return const Left('Empty List');
    // }
    // return Right(data.map((e) => AppCouponModel.fromJson(e.data()!)).toList());
    return Right(await fetchListBanner());
  }
}

Future<Map<String, BannerModel>> fetchListBanner() async {
  await Future.delayed(const Duration(seconds: 2));
  return const {
    'banner_delivery': BannerModel(
      bannerId: 'banner_delivery',
      bannerImage: 'assets/images/banner/banner_delivery.png',
      bannerType: 'ads',
      bannerTag: ['ads'],
    ),
    'banner_food': BannerModel(
      bannerId: 'banner_food',
      bannerImage: 'assets/images/banner/banner_food.png',
      bannerType: 'ads',
      bannerTag: ['ads'],
    ),
    'banner_recipe_combo': BannerModel(
      bannerId: 'banner_recipe_combo',
      bannerImage: 'assets/images/banner/banner_recipe_combo.png',
      bannerType: 'ads',
      bannerTag: ['ads'],
    ),
    'banner_membership': BannerModel(
      bannerId: 'banner_membership',
      bannerImage: 'assets/images/banner/banner_membership.png',
      bannerType: 'ads',
      bannerTag: ['ads'],
    ),
    'beef_steak': BannerModel(
      bannerId: 'beef_steak',
      bannerImage: 'assets/images/banner/beef_steak.png',
      bannerType: 'alt',
      bannerTag: ['alt'],
    ),
    'hamburger': BannerModel(
      bannerId: 'hamburger',
      bannerImage: 'assets/images/banner/hamburger.png',
      bannerType: 'alt',
      bannerTag: ['alt'],
    ),
  };
}
