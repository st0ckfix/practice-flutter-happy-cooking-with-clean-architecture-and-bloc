import 'dart:math';
import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/recipe_widget.dart';

class ListRecipeWidget extends StatelessWidget {
  const ListRecipeWidget({
    super.key,
    required this.listRecipes,
    this.tag,
  });

  final List<RecipeEntity> listRecipes;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: min(4, listRecipes.length),
        itemBuilder: (context, index) {
          return RecipeWidget(
            recipe: listRecipes[index],
            tag: tag,
            bottom: 5,
            left: 5,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
      ),
    );
  }
}
