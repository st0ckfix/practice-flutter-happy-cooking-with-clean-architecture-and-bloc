import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/product_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/control_button_widget.dart';

import '../common/cost_widget.dart';

class ProductHeaderLabelWidget extends StatelessWidget {
  const ProductHeaderLabelWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          product.productLabel,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: BlocBuilder<ProductSelectCubit, ProductSelect?>(
        builder: (context, productSelect) {
          final option = product.getOption(productSelect!.option!);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CostWidget(product: product, option: productSelect.option!),
                    Text(' • Sold ${product.productSold}')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all()),
                child: ListTile(
                  minVerticalPadding: 0,
                  horizontalTitleGap: 0,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  title: const Text('Option'),
                  subtitle: Text(option.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return OptionSelectBottomSheet(
                            product: product,
                            initSelect: productSelect.option!,
                            onClick: (select) {
                              context.read<ProductSelectCubit>().updateOption(select);
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  titleTextStyle: Theme.of(context).textTheme.labelMedium,
                  subtitleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
