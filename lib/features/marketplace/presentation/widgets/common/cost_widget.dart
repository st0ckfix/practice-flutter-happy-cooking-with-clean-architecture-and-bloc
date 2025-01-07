import 'package:flutter/material.dart';

import '../../../domain/entities/product_entity.dart';
import 'label_tag_widget.dart';

class CostWidget extends StatelessWidget {
  const CostWidget({super.key, required this.product, required this.option});

  final ProductEntity product;
  final int option;

  @override
  Widget build(BuildContext context) {
    final select = product.getOption(option);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: product.getTotalValue(option).toStringAsFixed(2),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: product.hasDiscount ? Colors.red : Colors.black,
                  ),
              children: [
                TextSpan(
                  text: '\$',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: product.hasDiscount ? Colors.red : Colors.black,
                      ),
                ),
              ],
            ),
          ),
          if (product.hasDiscount)
            Row(
              children: [
                LabelTagWidget.discountTag('-${(product.productDiscount * 100).toStringAsFixed(0)}%'),
                Text(
                  '${select.cost.toStringAsFixed(2)}\$',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
