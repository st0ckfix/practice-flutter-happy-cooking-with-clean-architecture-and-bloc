import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_buying/in_buying_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_confirm_delivery_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/select_list_widget.dart';

import '../../../domain/entities/product_entity.dart';

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
    final productSelect = context.read<ProductSelectCubit>().state!;
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
                      context.read<InQueueBloc>().add(
                            AddItem(
                              cartItem: CartItem(
                                foodId: productSelect.productId,
                                option: productSelect.option,
                              ),
                            ),
                          );
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
                context.read<InBuyingBloc>().add(
                      AddItem(
                        cartItem: CartItem(
                          foodId: productSelect.productId,
                          option: productSelect.option,
                        ),
                      ),
                    );
                Get.to(() => const ProductConfirmDeliveryPage());
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
    required this.initSelect,
    required this.onClick,
  });
  final ProductEntity product;
  final int initSelect;
  final Function(int option) onClick;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HolderSelect(initSelect),
      child: DraggableScrollableSheet(
        initialChildSize: 0.55,
        maxChildSize: 1,
        snap: true,
        expand: false,
        snapSizes: const [0.55, 1],
        builder: (context, scrollController) {
          final labelList = product.productOptions.map((e) => e.title).toList();
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                          child: Image.asset(product.productThumbnail, height: 100, width: 100, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              product.productLabel,
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
                                BlocBuilder<HolderSelect, int>(
                                  builder: (context, select) {
                                    return Text.rich(
                                      TextSpan(
                                        text: '${(product.getTotalValue(select)).toStringAsFixed(2)}\$',
                                        style: TextStyle(color: product.hasDiscount ? Colors.red : Colors.black),
                                        children: const [
                                          TextSpan(
                                            text: '/pakced',
                                            style: TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Option'),
                      ),
                      subtitle: SelectListWidget(
                        height: max(1, (product.productOptions.length / 3).floor()) * 42,
                        layoutBuilder: (context, index, isSelected) {
                          return Text(labelList[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: max(1, (product.productOptions.length / 3).floor()),
                          childAspectRatio: 1 / 2.5,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: product.productOptions.length,
                        onSelect: (pos, {selectList}) {
                          context.read<HolderSelect>().updateSelect(pos);
                        },
                        selectMode: SelectMode.single,
                        axis: Axis.horizontal,
                        itemInit: [initSelect],
                        addOnCheck: AddOnCheck.empty,
                      ),
                    )
                  ],
                ),
              ),
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
                    final select = context.read<HolderSelect>().state;
                    if (select != initSelect) {
                      onClick(select);
                    }
                    Get.back();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class HolderSelect extends Cubit<int> {
  HolderSelect(super.initialState);

  void updateSelect(int select) {
    if (state == select) return;
    emit(select);
  }
}
