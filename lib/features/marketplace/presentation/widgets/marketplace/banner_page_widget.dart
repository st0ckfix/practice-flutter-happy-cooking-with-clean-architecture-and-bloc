import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/empty_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/loading_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/entities/banner_entity.dart';

class BannerPageWidget extends StatelessWidget {
  const BannerPageWidget({super.key, this.banners});

  final List<BannerEntity>? banners;

  @override
  Widget build(BuildContext context) {
    if (banners == null) {
      return _buildLoadingList(context);
    } else if (banners!.isNotEmpty) {
      final controller = PageController(initialPage: 0);
      return Stack(
        children: [
          _buildPagerView(context, controller),
          Positioned(
            bottom: 20,
            right: 10,
            child: _buildPageIndicator(context, controller),
          ),
        ],
      );
    } else {
      return const EmptyWidget();
    }
  }

  Widget _buildLoadingList(BuildContext context) {
    return const LoadingItemWidget(height: 200, width: 400);
  }

  Widget _buildPagerView(BuildContext context, PageController controller) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        controller: controller,
        itemCount: banners!.length,
        itemBuilder: (context, index) {
          return Image.asset(
            banners![index].bannerImage,
            height: 200,
            width: 400,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context, PageController controller) {
    return SmoothPageIndicator(
      controller: controller,
      count: banners!.length,
      effect: const WormEffect(
        activeDotColor: Colors.blue,
        dotColor: Colors.grey,
        dotHeight: 10,
        dotWidth: 10,
      ),
    );
  }
}
