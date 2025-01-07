import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/category_detail/category_detail_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/category_detail_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/loading_item_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildHeader(context),
      subtitle: _buildBody(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const TitleWidget('Category'),
          const Spacer(),
          InkWellTextWidget(
            'See all',
            onClick: () => Get.to(() => const CategoryDetailPage(), duration: const Duration(milliseconds: 1500)),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
      builder: (context, state) {
        if (state is CategoryDetailLoading) {
          return _buildLoadingList();
        } else if (state is CategoryDetailLoaded) {
          return _buildCategoryList(state.listCategoryDetails!);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLoadingList() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => const LoadingItemWidget(height: 100, width: 100),
        separatorBuilder: (_, __) => const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryDetailEntity> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        cacheExtent: 1000,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => _buildCategoryItem(categories[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryDetailEntity category) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ProductFilterPage(
            title: category.label,
            foodTag: category.id,
          ),
          duration: const Duration(milliseconds: 1000),
        );
      },
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: category.id,
                child: Stack(
                  children: [
                    Image.asset(
                      category.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black87],
                            stops: [.4, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Text(
                category.label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
