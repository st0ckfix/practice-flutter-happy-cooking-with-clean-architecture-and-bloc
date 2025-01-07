import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/all_recipe_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/list_recipe_widget.dart';

import '../../../domain/entities/recipe_entity.dart';

class MainReceipeWidget extends StatelessWidget {
  const MainReceipeWidget({super.key, required this.listRecipes, required this.title, this.tag});
  final List<RecipeEntity> listRecipes;
  final String title;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _buildHerder(context),
      subtitle: _buildBody(context),
    );
  }

  Widget _buildHerder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          TitleWidget(title),
          const Spacer(),
          InkWellTextWidget(
            'See all',
            onClick: () {
              Get.to(
                () => AllRecipeWidget(listRecipes: listRecipes, tag: tag),
                duration: const Duration(
                  milliseconds: 1000,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListRecipeWidget(
      listRecipes: listRecipes,
      tag: tag,
    );
  }
}
