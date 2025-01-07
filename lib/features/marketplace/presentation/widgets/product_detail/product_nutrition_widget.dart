import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/nutrition_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/nutrition/nutrition_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

import '../common/expandable_list_widget.dart';

class ProductNutritionWidget extends StatelessWidget {
  const ProductNutritionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minVerticalPadding: 12,
        title: const TitleWidget('Product Nutritions'),
        subtitle: BlocBuilder<NutritionCubit, NutritionState>(
          builder: (context, state) {
            if (state is NutritionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NutritionError) {
              return const Center(
                child: Text('Fetching Got Error'),
              );
            } else if (state is NutritionData) {
              return ExpandableListWidget(
                listWidget: List<Widget>.from(state.nutritionEntity!.nutritionValue.entries.indexed
                    .map(
                      (e) => CateDetailWidget(
                        title: e.$2.key.label(),
                        subtitle: e.$2.value.toStringAsFixed(1) + e.$2.key.unit(),
                        color: e.$1.isEven ? Colors.grey.withOpacity(.2) : Colors.white,
                      ),
                    )
                    .toList())
                  ..add(const SizedBox(height: 10)),
                collapsePositions: const [0, 1, 2, 14],
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

class CateDetailWidget extends StatelessWidget {
  const CateDetailWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Expanded(
            child: Text(subtitle),
          ),
        ],
      ),
    );
  }
}
