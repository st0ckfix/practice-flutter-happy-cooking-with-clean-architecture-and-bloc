import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/product_confirm_delivery_bottom_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../cubit/product_manager_cubit.dart';

class ProductCartPage extends StatelessWidget {
  const ProductCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final InSelectProductCubit inSelectProductCubit = context.read<InSelectProductCubit>();
    final ProductDiscountCubit productDiscountCubit = context.read<ProductDiscountCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: BlocBuilder<InQueueListProductCubit<InQueueProduct>, List<InQueueProduct>>(
        builder: (context, queueShoppingList) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 15,
                right: 15,
                height: 40,
                child: Row(
                  children: [
                    queueShoppingList.isEmpty
                        ? Checkbox(value: false, onChanged: (value) {})
                        : BlocBuilder<InSelectProductCubit, List<String>>(
                            builder: (context, listSelect) {
                              return Checkbox(
                                value: queueShoppingList.length == listSelect.length,
                                onChanged: (value) {
                                  if (value!) {
                                    inSelectProductCubit.insertListProducts();
                                    productDiscountCubit.addMultiDiscount();
                                  } else {
                                    inSelectProductCubit.removeListProducts();
                                    productDiscountCubit.removeMultiDiscount();
                                  }
                                },
                              );
                            },
                          ),
                    Text(
                      'All products (${queueShoppingList.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.trash_alt)),
                  ],
                ),
              ),
              const Positioned(
                top: 45,
                left: 0,
                right: 0,
                child: Divider(thickness: 2, height: 1),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                bottom: 150,
                child: queueShoppingList.isEmpty
                    ? const Center(
                        child: Text('Empty Shopping Cart'),
                      )
                    : Builder(builder: (context) {
                        return BlocBuilder<InSelectProductCubit, List<String>>(
                          builder: (context, listSelect) {
                            return ListView.separated(
                              itemCount: queueShoppingList.length,
                              itemBuilder: (context, index) {
                                final queue = queueShoppingList[index];
                                final product = listProduct.firstWhere((element) => element.productId == queue.productId);
                                final classification = product.listClassification[queue.select];
                                final hasDiscount = product.discountPercent != .0;
                                final perValueDiscount = product.discountPercent * classification.cost;
                                final isCheck = listSelect.contains(queue.id);

                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isCheck,
                                          onChanged: (value) {
                                            if (value!) {
                                              inSelectProductCubit.insertProduct(queue.id);
                                              if (hasDiscount) {
                                                productDiscountCubit.addSingleDiscount(queue.id);
                                              }
                                            } else {
                                              inSelectProductCubit.removeProduct(queue.id);
                                              if (hasDiscount) {
                                                productDiscountCubit.removeSingleDiscount(queue.id);
                                              }
                                            }
                                          },
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          height: 100,
                                          width: 100,
                                          color: Colors.red,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(product.label, maxLines: 2, overflow: TextOverflow.ellipsis),
                                              Text(classification.label),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${(classification.cost - perValueDiscount).toStringAsFixed(2)}\$',
                                                    style: TextStyle(
                                                      color: hasDiscount ? Colors.red : Colors.black,
                                                      fontSize: 16,
                                                    ),
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
                                                          child: Text(
                                                            '-${(product.discountPercent * 100).toStringAsFixed(0)}%',
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          '${classification.cost.toStringAsFixed(2)}\$',
                                                          style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      context.read<InQueueListProductCubit<InQueueProduct>>().changeQuantity(queue.id, queue.quantity - 1);
                                                      if (hasDiscount) {
                                                        productDiscountCubit.addValueDiscount(-perValueDiscount);
                                                      }
                                                      if (isCheck) {
                                                        context.read<TotalCostCubit>().updateTotal();
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                    ),
                                                  ),
                                                  Text(queue.quantity.toString()),
                                                  IconButton(
                                                    onPressed: () {
                                                      context.read<InQueueListProductCubit<InQueueProduct>>().changeQuantity(queue.id, queue.quantity + 1);
                                                      if (hasDiscount) {
                                                        productDiscountCubit.addValueDiscount(perValueDiscount);
                                                      }
                                                      if (isCheck) {
                                                        context.read<TotalCostCubit>().updateTotal();
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Divider(height: 15, thickness: 1),
                                );
                              },
                            );
                          },
                        );
                      }),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ProductConfirmDeliveryBottomWidget(inCart: true),
              ),
            ],
          );
        },
      ),
    );
  }
}
