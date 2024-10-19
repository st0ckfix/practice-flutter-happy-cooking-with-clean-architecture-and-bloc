import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cost_cubit.dart';

bool isOpen = false;

class CostReviewWidget extends StatelessWidget {
  const CostReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final membership = context.read<MembershipCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
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
              if (membership.memberType != MemberType.none)
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
                    '-${membership.deliveryDiscount.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    BlocBuilder<TotalCostCubit, InCountProduct>(
                      builder: (context, totalCost) {
                        return Text(
                          '-${totalCost.totalSave.toStringAsFixed(2)}\$',
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
                      BlocBuilder<TotalCostCubit, InCountProduct>(
                        builder: (context, inCount) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 5, right: 0, left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Coupon discount',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    const Spacer(),
                                    Text(
                                      '-${inCount.couponSave.toStringAsFixed(2)}\$',
                                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                    Text(
                                      '-${inCount.productSave.toStringAsFixed(2)}\$',
                                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
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
                            BlocBuilder<TokenDiscountCubit, int>(
                              builder: (context, tokenDiscount) {
                                return Text(
                                  '-${(tokenDiscount / 100).toStringAsFixed(2)}\$',
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
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Text(
                'Bonus Tokens',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (membership.memberType != MemberType.none)
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
                    'x${membership.tokenScale}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Spacer(),
              BlocBuilder<TotalCostCubit, InCountProduct>(
                builder: (context, inCount) {
                  return Row(
                    children: [
                      Text(
                        '+${(inCount.tokenBonus * membership.tokenScale).round().toString()}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.yellow.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: 3),
                      Image.asset(
                        'assets/images/token.png',
                        height: 16,
                        width: 16,
                        color: Colors.yellow.shade700,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
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
