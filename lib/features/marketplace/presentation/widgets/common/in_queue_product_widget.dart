import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/cost_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/label_tag_widget.dart';

import '../../../domain/entities/product_entity.dart';
import '../product_detail/control_button_widget.dart';

class InQueueProductWidget extends StatelessWidget {
  const InQueueProductWidget({
    super.key,
    required this.productEntity,
    required this.cartItem,
    required this.isBestSeller,
    required this.updateProduct,
    required this.updateOption,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  final ProductEntity productEntity;
  final CartItem cartItem;
  final bool isBestSeller;
  final Function updateProduct;
  final Function(int option) updateOption;
  final Function increaseQuantity;
  final Function decreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        minLeadingWidth: 16,
        horizontalTitleGap: 0,
        title: Row(
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () => updateProduct(),
                  child: Image.asset(
                    productEntity.productThumbnail,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isBestSeller)
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: LabelTagWidget.fireTag('Best Seller', padding: const EdgeInsets.all(2)),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productEntity.productLabel, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 5),
                  IntrinsicWidth(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return OptionSelectBottomSheet(
                              product: productEntity,
                              initSelect: cartItem.option,
                              onClick: (option) {
                                updateOption(option);
                                //inRecipeBloc.add(UpdateOption(cartId: cartItem.cartId, foodId: cartItem.foodId, option: option));
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Row(
                          children: [
                            Text(
                              productEntity.getOption(cartItem.option).title,
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: IconButton(
                            iconSize: 16.0,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(width: 24, height: 24),
                            onPressed: () {
                              decreaseQuantity();
                              //inRecipeBloc.add(DecreaseQuantity(cartId: cartItem.cartId))
                            },
                            icon: const Icon(
                              Icons.remove,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text((cartItem.quantity).toString(), style: Theme.of(context).textTheme.labelLarge),
                      ),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: IconButton(
                            iconSize: 16.0,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(width: 24, height: 24),
                            onPressed: () {
                              increaseQuantity();
                              //inRecipeBloc.add(IncreaseQuantity(cartId: cartItem.cartId));
                            },
                            icon: const Icon(
                              Icons.add,
                            )),
                      ),
                      const Spacer(),
                      CostWidget(product: productEntity, option: cartItem.option),
                      const SizedBox(width: 10)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
