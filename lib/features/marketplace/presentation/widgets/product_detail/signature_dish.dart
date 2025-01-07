import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/recipe_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductSignatureDish extends StatelessWidget {
  const ProductSignatureDish({super.key, required this.foodType});

  final String foodType;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    final cubit = context.read<AllRecipeCubit>();
    final listRecipeId = cubit.getListRecipesByFoodType(foodType: foodType)!;

    if (listRecipeId.isEmpty) return const SizedBox.shrink();

    Widget pageView = SizedBox(
      height: 150,
      child: PageView.builder(
        controller: controller,
        itemCount: listRecipeId.length,
        itemBuilder: (context, index) {
          final recipe = cubit.getRecipeByRecipeId(recipeId: listRecipeId[index])!;
          return RecipeWidget(
            recipe: recipe,
            width: 400,
            height: 150,
            top: 20,
            left: 20,
            titleSize: 20,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [Colors.black87, Colors.transparent],
            stops: const [.15, 1],
          );
        },
      ),
    );
    Widget indicator = SmoothPageIndicator(
      controller: controller,
      count: listRecipeId.length,
      effect: const ExpandingDotsEffect(
        activeDotColor: Colors.blueAccent,
        dotColor: Colors.grey,
        dotWidth: 10,
        dotHeight: 10,
      ),
    );
    return ListTile(
      title: const TitleWidget('Signature Dish'),
      subtitle: Stack(
        children: [
          pageView,
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: indicator,
            ),
          ),
        ],
      ),
    );
  }
}
