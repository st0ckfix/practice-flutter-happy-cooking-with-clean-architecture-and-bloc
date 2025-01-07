import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/banner_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/banner_usecase.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerUseCase bannerUseCase;
  Map<String, List<String>>? listBannerByType;
  Map<String, List<String>>? listBannerByTag;
  BannerCubit({required this.bannerUseCase}) : super(BannerInitial()) {
    fetchListBanner();
  }

  Future<void> fetchListBanner() async {
    emit(const BannerLoading());
    final either = await bannerUseCase();
    either.fold(
      (error) {
        emit(BannerError(error));
      },
      (banners) {
        emit(BannerLoaded(banners));
      },
    );
  }

  List<String>? setListBannerByType({required String bannerType}) {
    final finalList = state.mapBanners!.values.where((element) => element.bannerType == bannerType).map((e) => e.bannerId).toList();
    listBannerByType![bannerType] = finalList;
    return finalList;
  }

  List<String>? getListBannerByType({required String? bannerType}) {
    if (bannerType == null) return null;
    return listBannerByType![bannerType] ?? setListBannerByType(bannerType: bannerType);
  }

  List<String>? setListBannerByTag({required String bannerTag}) {
    final finalList = state.mapBanners!.values.where((element) => element.bannerTag.contains(bannerTag)).map((e) => e.bannerId).toList();
    listBannerByType?[bannerTag] = finalList;
    return finalList;
  }

  List<String>? getListBannerByTag({required String? bannerTag}) {
    if (bannerTag == null) return null;
    return listBannerByType?[bannerTag] ?? setListBannerByTag(bannerTag: bannerTag);
  }

  BannerEntity? getBannerByBannerId({required String bannerId}) {
    return state.mapBanners?[bannerId];
  }
}
