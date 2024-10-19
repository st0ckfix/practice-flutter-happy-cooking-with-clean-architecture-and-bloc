import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../cubit/product_manager_cubit.dart';

class DeliveryMethodAndProductSummaryWidget extends StatelessWidget {
  const DeliveryMethodAndProductSummaryWidget({super.key, this.select});
  final int? select;
  @override
  Widget build(BuildContext context) {
    final membership = context.read<MembershipCubit>().state;
    final deliveryToday = DeliveryOption.today();
    final deliveryLater = DeliveryOption.later();
    return BlocBuilder<DeliveryCostCubit, DeliveryOption>(
      builder: (context, deliveryOption) {
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Delivery Option'),
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.lightBlue, width: 1),
                  color: Colors.blue.withOpacity(.1),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15),
                      leading: const Icon(LineAwesomeIcons.car_solid),
                      title: Text(deliveryToday.label),
                      subtitle: const Text('Discount 1\$ w/ Membership'),
                      trailing: Radio(
                        value: deliveryToday.cost,
                        groupValue: deliveryOption.cost,
                        onChanged: (value) {
                          context.read<DeliveryCostCubit>().updateDelivery(deliveryToday);
                        },
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15),
                      leading: const Icon(LineAwesomeIcons.motorcycle_solid),
                      title: Text(deliveryLater.label),
                      subtitle: const Text('Discount 1\$ w/ Membership'),
                      trailing: Radio(
                        value: deliveryLater.cost,
                        groupValue: deliveryOption.cost,
                        onChanged: (value) {
                          context.read<DeliveryCostCubit>().updateDelivery(deliveryLater);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 2, height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  BlocBuilder<DeliveryDiscountCubit, double>(
                    builder: (context, deliveryDiscount) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(deliveryOption.message),
                        subtitle: Row(
                          children: [
                            const Text('Delivery Cost'),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: membership.memberType == MemberType.gold
                                    ? const Color(0xFFFFD700)
                                    : membership.memberType == MemberType.platinum
                                        ? const Color(0xFFE5E4E2)
                                        : const Color(0xFFB9F2FF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                membership.memberType == MemberType.gold
                                    ? 'GOLD'
                                    : membership.memberType == MemberType.platinum
                                        ? 'PLATIUM'
                                        : 'DIAMOND',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (membership.memberType == MemberType.none)
                              Text(
                                '${deliveryOption.cost}\$',
                              )
                            else
                              Text(
                                '${max(0, deliveryOption.cost - membership.deliveryDiscount).toStringAsFixed(2)}\$',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                  ConfirmSelectListWidget(select: select)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ConfirmSelectListWidget extends StatelessWidget {
  const ConfirmSelectListWidget({super.key, this.select});

  final int? select;

  @override
  Widget build(BuildContext context) {
    return select == null
        ? BlocBuilder<InSelectListProductCubit, List<String>>(
            builder: (context, listId) {
              final inQueueListProduct = context.read<InQueueListProductCubit<InQueueProduct>>().state;
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final queue = inQueueListProduct.firstWhere((element) => listId[index] == element.id);
                  final product = listProduct.firstWhere((element) => element.productId == queue.productId);
                  return ConfirmProductWidget(product: product, queue: queue);
                },
                separatorBuilder: (context, index) {
                  return const Divider(thickness: 1);
                },
                itemCount: listProduct.length,
              );
            },
          )
        : BlocBuilder<ProductSelectCubit, ProductSelect?>(
            builder: (context, productSelect) {
              final product = productSelect!.product!;
              return ConfirmProductWidget(
                product: product,
                queue: InQueueProduct(
                  id: 'buying-now',
                  productId: product.productId,
                  select: select!,
                ),
              );
            },
          );
  }
}

class ConfirmProductWidget extends StatelessWidget {
  const ConfirmProductWidget({
    super.key,
    required this.product,
    required this.queue,
  });

  final Product product;
  final InQueueProduct queue;

  @override
  Widget build(BuildContext context) {
    final classification = product.listClassification[queue.select];
    final hasDiscount = product.discountPercent != .0;
    final finalValue = classification.cost * (1 - product.discountPercent);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      leading: Container(
        alignment: Alignment.topCenter,
        height: 60,
        width: 60,
        color: Colors.amber,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Text(
                'classification: ${classification.label}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text(
            'quantity: x${queue.quantity}',
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          Text(
            '${classification.cost}\$',
            style: TextStyle(
              fontSize: hasDiscount ? 12 : 14,
              decoration: hasDiscount ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          if (hasDiscount)
            Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  '${finalValue.toStringAsFixed(2)}\$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
