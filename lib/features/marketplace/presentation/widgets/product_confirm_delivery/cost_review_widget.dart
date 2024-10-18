import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/app_coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/another_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cost_cubit.dart';

import '../../cubit/discount_value_cubit.dart';

bool isOpen = false;

class CostReviewWidget extends StatelessWidget {
  const CostReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Text('Subtotal', style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              BlocBuilder<TotalCostCubit, InCountProduct>(
                builder: (context, inCount) {
                  
                  return Text(
                    '${inCount.subtotal.toStringAsFixed(2)}\$',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Text(
                'Delivery cost',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              BlocBuilder<DeliveryCostCubit, DeliveryOption>(
                builder: (context, deliveryOption) {
                  return Text(
                    '${deliveryOption.cost.toStringAsFixed(2)}\$',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Text(
                'Delivery discount',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              BlocBuilder<DeliveryDiscountCubit, double>(
                builder: (context, deliveryDiscount) {
                  return Text(
                    '-${deliveryDiscount.toStringAsFixed(2)}\$',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        StatefulBuilder(builder: (context, stateful) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        stateful(() {
                          isOpen = !isOpen;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            'Another discount',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Icon(isOpen ? Icons.arrow_drop_down : Icons.arrow_drop_up)
                        ],
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<AnotherDiscountCubit, double>(
                      builder: (context, anotherDiscount) {
                        return Text(
                          '-${anotherDiscount.toStringAsFixed(2)}\$',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                        );
                      },
                    ),
                  ],
                ),
                if (isOpen)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5, right: 0, left: 10),
                        child: Row(
                          children: [
                            Text(
                              'App discount',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<AppDiscountCubit, AppCouponEntity?>(
                              builder: (context, appCoupon) {
                                return Text(
                                  '-${(appCoupon?.cost ?? .0).toStringAsFixed(2)}\$',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5, right: 0, left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Product discount',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<ProductDiscountCubit, double>(
                              builder: (context, productDiscount) {
                                return Text(
                                  '-${productDiscount.toStringAsFixed(2)}\$',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5, right: 0, left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Sale discount',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<SaleDiscountCubit, double>(
                              builder: (context, saleDiscount) {
                                return Text(
                                  '-${saleDiscount.toStringAsFixed(2)}\$',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5, right: 0, left: 10),
                        child: Row(
                          children: [
                            Text(
                              'Token discount',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const Spacer(),
                            BlocBuilder<TokenDiscountCubit, double>(
                              builder: (context, tokenDiscount) {
                                return Text(
                                  '-${tokenDiscount.toStringAsFixed(2)}\$',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            ),
          );
        }),
        const Divider(thickness: 2, height: 5),
        Container(
          padding: const EdgeInsets.only(
            top: 5,
            left: 15,
            right: 15,
          ),
          child: Row(
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              const Spacer(),
              BlocBuilder<TotalCostCubit, InCountProduct>(
                builder: (context, inCount) {
                  return Text(
                    '${inCount.total.toStringAsFixed(2)}\$',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 50, right: 15, bottom: 10),
          child: Text(
            '(This is the final price, including taxes and shipping costs, no other costs will be incurred)',
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          color: const Color(0x1F000000),
          padding: const EdgeInsets.all(15),
          child: const Text.rich(
            TextSpan(
              text: 'By placing an order, you agree to the ',
              children: [
                TextSpan(
                  text: 'General Terms and Conditions.',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
