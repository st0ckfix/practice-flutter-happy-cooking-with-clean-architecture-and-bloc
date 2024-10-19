import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/control_button_widget.dart';

class ProductHeaderLabelWidget extends StatelessWidget {
  const ProductHeaderLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSelectCubit, ProductSelect?>(
      builder: (context, productSelect) {
        final product = productSelect!.product!;
        final select = productSelect.select!;
        final productClassification = product.listClassification[select];
        final hasDiscount = product.discountPercent != .0;
        final finalValue = productClassification.cost * (1 - product.discountPercent);
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.label,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Row(
                  children: [
                    Text('4.5'),
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      halfFilledIcon: Icons.star_half,
                      emptyIcon: Icons.star_border,
                      initialRating: 4.5,
                      isHalfAllowed: true,
                      maxRating: 5,
                      size: 16,
                    ),
                    Text('(9)'),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 3), child: Text('|')),
                    Text('Sold 15')
                  ],
                )
              ],
            ),
          ),
          subtitle: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${finalValue.toStringAsFixed(2)}\$',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    if (hasDiscount)
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.withOpacity(.5),
                            ),
                            child: Text('-${(product.discountPercent * 100).toStringAsFixed(0)}%'),
                          ),
                          Text(
                            '${productClassification.cost}\$',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all()),
                child: ListTile(
                  minVerticalPadding: 0,
                  horizontalTitleGap: 0,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: const Text('Classification'),
                  subtitle: Text(productClassification.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return OptionSelectBottomSheet(
                            product: product,
                            select: select,
                          );
                        },
                      );
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.blue),
                    ),
                  ),
                  titleTextStyle: Theme.of(context).textTheme.labelMedium,
                  subtitleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
