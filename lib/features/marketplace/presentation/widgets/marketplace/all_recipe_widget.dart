import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/recipe_widget.dart';

import '../../../domain/entities/recipe_entity.dart';

class AllRecipeWidget extends StatelessWidget {
  const AllRecipeWidget({super.key, required this.listRecipes, this.tag});

  final List<RecipeEntity> listRecipes;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            itemCount: listRecipes.length,
            itemBuilder: (context, index) {
              return RecipeWidget(
                recipe: listRecipes[index],
                height: 180,
                width: double.maxFinite - 20,
                titleSize: 18,
                tag: tag,
                bottom: 5,
                left: 5,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          ),
        ),
      ),
    );
  }
}
