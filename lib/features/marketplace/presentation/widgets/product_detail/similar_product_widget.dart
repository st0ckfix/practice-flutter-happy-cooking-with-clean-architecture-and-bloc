import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/list_product_item_widget.dart';

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({super.key, required this.foodType});

  final String foodType;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductCubit>();
    final listProductIdByType = cubit.getListProductIdByFoodType(foodType: foodType)!;
    return ListTile(
      title: const TitleWidget('Similar Products'),
      subtitle: SizedBox(
        child: ListProductItemWidget(
          listProduct: listProductIdByType
              .map(
                (e) => cubit.getProductByFoodId(foodId: e)!,
              )
              .toList(),
        ),
      ),
    );
  }
}
