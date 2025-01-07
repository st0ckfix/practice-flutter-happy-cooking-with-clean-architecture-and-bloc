import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/product/product_cubit.dart';
import '../common/title_widget.dart';
import 'list_product_item_widget.dart';

class FilterProductWidget extends StatelessWidget {
  const FilterProductWidget({super.key, required this.title, this.foodType, this.foodTag, this.getTopDeals = false});

  final String title;
  final String? foodTag;
  final String? foodType;
  final bool getTopDeals;

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    return ListTile(
      title: TitleWidget(title),
      subtitle: BlocBuilder<ProductCubit, ProductState>(builder: (_, state) {
        if (state is ProductError) {
          return const ListProductItemWidget(listProduct: []);
        } else if (state is ProductData) {
          final listIds = productCubit.getListProductIdByFoodTag(
                foodTag: foodTag,
                end: 10,
              ) ??
              productCubit.getListProductIdByFoodType(
                foodType: foodType,
                end: 10,
              ) ??
              (getTopDeals
                  ? productCubit.getTopDealsListProductIdByAll(
                      end: 10,
                    )
                  : productCubit.getListProductsId());
          if (listIds == null) {
            return const ListProductItemWidget(listProduct: []);
          }
          final listProduct = listIds.map((e) => productCubit.getProductByFoodId(foodId: e)!).toList();
          return ListProductItemWidget(listProduct: listProduct);
        }
        return const ListProductItemWidget();
      }),
    );
  }
}
