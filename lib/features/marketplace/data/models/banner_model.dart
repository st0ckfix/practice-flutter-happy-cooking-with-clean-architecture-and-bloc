import 'package:happy_cooking/features/marketplace/domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.bannerId,
    required super.bannerImage,
    required super.bannerType,
    required super.bannerTag,
  });
}
