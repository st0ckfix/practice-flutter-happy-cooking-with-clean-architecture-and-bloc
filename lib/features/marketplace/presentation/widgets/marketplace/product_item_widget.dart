import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/label_tag_widget.dart';

import '../../../domain/entities/product_entity.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
    required this.select,
    required this.isBestSeller,
  });

  final ProductEntity product;
  final int select;
  final bool isBestSeller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 150,
                alignment: Alignment.center,
                child: Image.asset(
                  product.productThumbnail,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 150,
                child: Container(
                  margin: const EdgeInsets.only(left: 8, right: 4, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.productLabel, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text.rich(
                        TextSpan(
                          text: '${(product.getTotalValue(select)).toStringAsFixed(2)}\$',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                          children: [
                            TextSpan(
                              text: ' ${product.getOption(select).title}',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isBestSeller)
          Positioned(
            top: 10,
            left: 10,
            child: LabelTagWidget.fireTag(
              'Best Seller',
              fontSize: 12,
            ),
          ),
        if (product.hasDiscount)
          Positioned(
            top: 10,
            right: 5,
            child: LabelTagWidget.discountTag(
              '-${(product.productDiscount * 100).toStringAsFixed(0)}%',
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
