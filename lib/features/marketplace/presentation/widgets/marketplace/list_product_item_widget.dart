import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_detail_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/empty_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/loading_item_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/product_item_widget.dart';

import '../../../domain/entities/product_entity.dart';
import '../../cubit/product_select_cubit.dart';

class ListProductItemWidget extends StatelessWidget {
  const ListProductItemWidget({
    super.key,
    this.listProduct,
  });

  final List<ProductEntity>? listProduct;

  @override
  Widget build(BuildContext context) {
    if (listProduct == null) {
      return _buildLoadingList();
    } else if (listProduct!.isNotEmpty) {
      return _buildProductList(context, listProduct!);
    } else {
      return const EmptyWidget();
    }
  }

  Widget _buildProductList(BuildContext context, List<ProductEntity> listProduct) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: listProduct.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            context.read<ProductSelectCubit>().updateProduct(listProduct[index].productId);
            Get.to(() => const ProductDetailPage());
          },
          child: ProductItemWidget(
            product: listProduct[index],
            select: 0,
            isBestSeller: false,
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 5),
      ),
    );
  }

  Widget _buildLoadingList() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => const LoadingItemWidget(height: 220, width: 150),
        separatorBuilder: (_, __) => const SizedBox(width: 10),
      ),
    );
  }
}
