import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/receipe_ingredients_widget.dart';

import '../../cubit/recipe_select_cubit.dart';

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({
    super.key,
    required this.recipe,
    this.tag,
    this.height = 120.0,
    this.width = 220.0,
    this.titleSize = 14,
    this.begin,
    this.end,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.colors,
    this.stops,
  });

  final String? tag;
  final RecipeEntity recipe;
  final double height;
  final double width;
  final double titleSize;
  final Alignment? begin;
  final Alignment? end;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final List<Color>? colors;
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<RecipeSelectCubit>().addRecipe(recipe: recipe);
        Get.to(
          () => ReceipeIngredientsWidget(recipeEntity: recipe, tag: tag),
          duration: const Duration(
            milliseconds: 1000,
          ),
        );
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: tag.toString() + recipe.recipeId,
                child: Stack(
                  children: [
                    Image.asset(
                      recipe.recipeImage,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: colors ?? const [Colors.transparent, Colors.black87],
                            begin: begin ?? Alignment.topCenter,
                            end: end ?? Alignment.bottomCenter,
                            stops: stops ?? const [.4, 1],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: top,
              bottom: bottom,
              left: left,
              right: right,
              child: Text(
                recipe.recipeTitle,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
