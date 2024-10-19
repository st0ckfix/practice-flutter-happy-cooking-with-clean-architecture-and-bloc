import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_confirm_delivery_page.dart';

import '../../cubit/product_manager_cubit.dart';

class ControlButtonWidget extends StatelessWidget {
  const ControlButtonWidget({
    super.key,
    required this.addToCart,
    required this.globalKey,
  });

  final GlobalKey globalKey;
  final Function addToCart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Stack(
              children: [
                Container(
                  key: globalKey,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/package.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: double.maxFinite,
                  child: CustomButton(
                    isOutlined: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    title: 'Add To Cart',
                    fontSize: 16,
                    fontColor: Colors.black,
                    onClick: () {
                      final productSelect = context.read<ProductSelectCubit>().state!;
                      final inQueueCubit = context.read<InQueueListProductCubit<InQueueProduct>>();
                      final inQueueProduct = inQueueCubit.state.firstWhereOrNull((element) => element.productId == productSelect.product!.productId);
                      if (inQueueProduct != null && inQueueProduct.select == productSelect.select) {
                        context.read<InQueueListProductCubit<InQueueProduct>>().changeQuantity(inQueueProduct.id, inQueueProduct.quantity + 1);
                      } else {
                        context.read<InQueueListProductCubit<InQueueProduct>>().insertProduct(
                              InQueueProduct(
                                id: (DateTime.now().millisecondsSinceEpoch / 1000).round().toString(),
                                productId: productSelect.product!.productId,
                                select: productSelect.select!,
                              ),
                            );
                      }

                      addToCart();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5),
            child: CustomButton(
              isOutlined: false,
              padding: const EdgeInsets.symmetric(vertical: 10),
              title: 'Buying Now',
              fontSize: 16,
              onClick: () {
                final productSelect = context.read<ProductSelectCubit>().state!;
                context.read<InSelectListProductCubit>().insertProduct(Random().nextInt(1000000).toString());
                Get.to(() => ProductConfirmDeliveryPage(select: productSelect.select));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class OptionSelectBottomSheet extends StatelessWidget {
  const OptionSelectBottomSheet({
    super.key,
    required this.product,
    required this.select,
  });
  final Product product;
  final int select;
  @override
  Widget build(BuildContext context) {
    var selectItem = select;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 1,
      snap: true,
      expand: false,
      snapSizes: const [0.55, 1],
      builder: (context, scrollController) {
        return Stack(
          children: [
            StatefulBuilder(builder: (context, stateful) {
              return Container(
                margin: const EdgeInsets.only(top: 25),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.yellow,
                          margin: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              product.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Provided by: SP-AL',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${product.listClassification[selectItem].cost.toStringAsFixed(2)}\$ /packed',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: const Text('Option'),
                      subtitle: ChipsChoice<int>.single(
                        wrapped: true,
                        direction: Axis.horizontal,
                        value: selectItem,
                        onChanged: (value) {},
                        choiceBuilder: (item, i) {
                          return IntrinsicWidth(
                            child: InkWell(
                              onTap: () {
                                stateful(() {
                                  selectItem = item.value;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: selectItem == item.value ? Colors.blue : Colors.black),
                                  color: selectItem == item.value ? Colors.lightBlue : Colors.transparent,
                                ),
                                child: Text(
                                  product.listClassification[i].label,
                                  style: TextStyle(
                                    fontWeight: selectItem == item.value ? FontWeight.bold : FontWeight.normal,
                                    color: selectItem == item.value ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        choiceItems: C2Choice.listFrom<int, int>(
                          source: [0, 1, 2],
                          value: (index, item) => item,
                          label: (index, item) => '',
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: CustomButton(
                isOutlined: false,
                padding: const EdgeInsets.symmetric(vertical: 10),
                fontSize: 16,
                title: 'SELECT',
                onClick: () {
                  if (selectItem != select) {
                    context.read<ProductSelectCubit>().updateProduct(
                          ProductSelect(
                            product: product,
                            select: selectItem,
                          ),
                        );
                  }
                  Get.back();
                },
              ),
            )
          ],
        );
      },
    );
  }
}
