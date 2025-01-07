import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_buying/in_buying_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_queue_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/product_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_confirm_delivery_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_detail_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/in_queue_product_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../core/common_widget/custom_button.dart';

class ProductCartPage extends StatelessWidget {
  const ProductCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inQueueBloc = context.read<InQueueBloc>();
    final productCubit = context.read<ProductCubit>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
        title: const Text('Shopping Cart'),
        actions: [
          BlocSelector<InQueueBloc, CartState, bool>(
            selector: (state) {
              return state.isAllSelected;
            },
            builder: (context, isSelectedAll) {
              return Checkbox(
                value: isSelectedAll,
                onChanged: (value) {
                  final event = value! ? const SelectAll() : const UnselectAll();
                  inQueueBloc.add(event);
                },
              );
            },
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Do you want to clear all items in cart?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        inQueueBloc.add(
                          RemoveMultiItem(),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              LineAwesomeIcons.trash_alt,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            bottom: 70,
            child: BlocSelector<InQueueBloc, CartState, int>(
              selector: (state) {
                return state.getListItems.length;
              },
              builder: (context, itemCount) {
                if (itemCount == 0) {
                  return const Center(child: Text('No items in cart'));
                }
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return BlocSelector<InQueueBloc, CartState, CartItem>(
                      selector: (state) {
                        return state.getListItems[index];
                      },
                      builder: (context, cartItem) {
                        final productEntity = productCubit.getProductByFoodId(foodId: cartItem.foodId)!;

                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {}),
                            children: const [],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => actionDialog(context, inQueueBloc, cartItem),
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Remove',
                              ),
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: const Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: 'Favorite',
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: cartItem.isSelect,
                                onChanged: (value) {
                                  final event = value! ? SelectSingle(cartId: cartItem.cartId) : UnselectSingle(cartId: cartItem.cartId);
                                  inQueueBloc.add(event);
                                },
                              ),
                              Expanded(
                                child: InQueueProductWidget(
                                  productEntity: productEntity,
                                  cartItem: cartItem,
                                  isBestSeller: false,
                                  updateProduct: () {
                                    context.read<ProductSelectCubit>().updateProduct(productEntity.productId);
                                    Get.to(() => const ProductDetailPage(), duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                                  },
                                  updateOption: (option) {
                                    inQueueBloc.add(UpdateOption(cartId: cartItem.cartId, foodId: cartItem.foodId, option: option));
                                  },
                                  increaseQuantity: () {
                                    inQueueBloc.add(IncreaseQuantity(cartId: cartItem.cartId));
                                  },
                                  decreaseQuantity: () {
                                    if (cartItem.quantity == 1) {
                                      actionDialog(context, inQueueBloc, cartItem);
                                    } else {
                                      inQueueBloc.add(DecreaseQuantity(cartId: cartItem.cartId));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(height: 10, thickness: 1),
                    );
                  },
                  itemCount: itemCount,
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _bottomReview(context),
          ),
        ],
      ),
    );
  }

  Future actionDialog(BuildContext context, InQueueBloc inQueueBloc, CartItem cartItem) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do you want to remove item'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                inQueueBloc.add(RemoveItem(cartId: cartItem.cartId));
                Navigator.pop(context);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}

Widget _bottomReview(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(5),
    child: Card(
      elevation: 1,
      child: ListTile(
        title: BlocBuilder<InQueueCostCubit, ProductCost>(
          builder: (context, state) {
            return Row(
              children: [
                const Text('Subtotal'),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    text: state.subtotal.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                    children: [
                      TextSpan(
                        text: '\$',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        subtitle: CustomButton(
          padding: const EdgeInsets.symmetric(vertical: 10),
          title: 'Order',
          isOutlined: false,
          fontColor: Colors.white,
          onClick: () {
            context.read<InBuyingBloc>().add(
                  AddMultiItem(
                    cartItems: context.read<InQueueBloc>().state.getSelectedItems,
                  ),
                );
            Get.to(
              () => const ProductConfirmDeliveryPage(),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    ),
  );
}
