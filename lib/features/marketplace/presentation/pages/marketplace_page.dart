import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/badge_cart_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/custom_search_delegate.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/banner_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/category_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/main_control_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/main_receipe_widget.dart';

import '../widgets/marketplace/filter_product_widget.dart';

class MarketPlacePage extends StatelessWidget {
  const MarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: CustomSearchDelegate(
                suggestionInitial: productCubit.getTopDealsListProductByAll()!,
              ),
            ),
            icon: const Icon(
              Icons.search,
            ),
          ),
          const BadgeCartWidget(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: MainControlWidget(),
          ),
          const SliverToBoxAdapter(
            child: BannerWidget(bannerTag: 'ads'),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<AllRecipeCubit, RecipeState>(
              builder: (context, state) {
                if (state is RecipeData) {
                  return MainReceipeWidget(
                    title: 'My Recipes',
                    listRecipes: context.read<AllRecipeCubit>().getMyRecipes,
                    tag: 'my-recipe',
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: CategoryWidget(),
          ),
          const SliverToBoxAdapter(
            child: FilterProductWidget(title: 'Populars'),
          ),
          const SliverToBoxAdapter(
            child: FilterProductWidget(title: 'Top Deals', getTopDeals: true),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<AllRecipeCubit, RecipeState>(
              builder: (context, state) {
                if (state is RecipeData) {
                  return MainReceipeWidget(
                    title: 'Top Recipes',
                    listRecipes: context.read<AllRecipeCubit>().getTopRecipes,
                    tag: 'top-recipe',
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: BannerWidget(bannerTag: 'alt'),
          ),
          ...[('Meats', 'meat'), ('Seafoods', 'seafood'), ('Fruits', 'fruit'), ('Vegetables', 'vegetable')].map(
            (e) => SliverToBoxAdapter(
              child: FilterProductWidget(
                title: e.$1,
                foodTag: e.$2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
