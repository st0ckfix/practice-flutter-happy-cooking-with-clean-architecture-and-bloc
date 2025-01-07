import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String bannerId;
  final String bannerImage;
  final String bannerType;
  final List<String> bannerTag;

  const BannerEntity({
    required this.bannerId,
    required this.bannerImage,
    required this.bannerType,
    required this.bannerTag,
  });

  @override
  List<Object?> get props => [bannerId, bannerImage, bannerType, bannerTag];
}
