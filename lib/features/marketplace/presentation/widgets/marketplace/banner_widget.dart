import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/banner/banner_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/banner_page_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    this.title,
    this.bannerType,
    this.bannerTag,
  });
  final String? bannerType;
  final String? bannerTag;
  final Widget? title;
  @override
  Widget build(BuildContext context) {
    final bannerCubit = context.read<BannerCubit>();
    return ListTile(
      minVerticalPadding: 0,
      title: title,
      subtitle: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerLoading) {
            return const BannerPageWidget();
          } else if (state is BannerError) {
            return const BannerPageWidget(banners: []);
          }
          final bannerIds = bannerCubit.getListBannerByTag(
                bannerTag: bannerTag,
              ) ??
              bannerCubit.getListBannerByType(
                bannerType: bannerType,
              );
          final banners = bannerIds!
              .map(
                (bannerId) => bannerCubit.getBannerByBannerId(bannerId: bannerId)!,
              )
              .toList();
          return BannerPageWidget(banners: banners);
        },
      ),
    );
  }
}
