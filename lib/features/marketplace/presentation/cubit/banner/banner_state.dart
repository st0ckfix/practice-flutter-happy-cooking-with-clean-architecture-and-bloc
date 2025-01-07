part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  final Map<String, BannerEntity>? mapBanners;
  final String? error;
  const BannerState({this.mapBanners, this.error});

  @override
  List<Object> get props => [mapBanners!, error!];
}

final class BannerInitial extends BannerState {
  BannerInitial() : super(mapBanners: {});
}

final class BannerLoading extends BannerState {
  const BannerLoading() : super();
}

final class BannerLoaded extends BannerState {
  const BannerLoaded(Map<String, BannerEntity> mapBanners) : super(mapBanners: mapBanners);
}

final class BannerError extends BannerState {
  const BannerError(String error) : super(error: error);
}
