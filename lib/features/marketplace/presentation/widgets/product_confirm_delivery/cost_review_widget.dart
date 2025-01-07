import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cubit.dart';

import '../common/label_tag_widget.dart';

bool isOpen = false;

class CostReviewWidget extends StatelessWidget {
  const CostReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final membership = context.read<MembershipCubit>();
    final discountLabel = membership.membershipDiscountLabel();
    final tokenbonusLabel = membership.membershipTokenBonusLabel();

    LabelTagWidget? membershipTag;
    LabelTagWidget? tokenbonusTag;

    switch (membership.state.memberType) {
      case MemberType.gold:
        membershipTag = LabelTagWidget.goldTag(
          discountLabel,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 5),
        );
        tokenbonusTag = LabelTagWidget.tokenBonusTag(
          tokenbonusLabel,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 5),
        );
        break;
      case MemberType.platinum:
        membershipTag = LabelTagWidget.platinumTag(
          discountLabel,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 5),
        );
        tokenbonusTag = LabelTagWidget.tokenBonusTag(
          tokenbonusLabel,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 5),
        );
        break;
      case MemberType.diamond:
        membershipTag = LabelTagWidget.diamonTag(
          discountLabel,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 5),
        );
        tokenbonusTag = LabelTagWidget.tokenBonusTag(
          tokenbonusLabel,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          margin: const EdgeInsets.only(left: 5),
        );
        break;
      default:
    }

    return BlocBuilder<TotalCubit, Total>(
      builder: (context, total) {
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
                  BlocSelector<TotalCubit, Total, double>(
                    selector: (total) {
                      return total.subtotal;
                    },
                    builder: (context, subtotal) {
                      return Text(
                        '${subtotal.toStringAsFixed(2)}\$',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  )
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
                  BlocSelector<TotalCubit, Total, double>(
                    selector: (total) {
                      return total.deliveryCost;
                    },
                    builder: (context, deliveryCost) {
                      return Text(
                        '${deliveryCost.toStringAsFixed(2)}\$',
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
                  membershipTag ?? const SizedBox.shrink(),
                  const Spacer(),
                  BlocSelector<TotalCubit, Total, double>(
                    selector: (total) {
                      return total.deliveryDiscount;
                    },
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
                        BlocSelector<TotalCubit, Total, double>(
                          selector: (total) {
                            return total.anotherSave;
                          },
                          builder: (context, anotherSave) {
                            return Text(
                              '-${anotherSave.toStringAsFixed(2)}\$',
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
                                BlocBuilder<CouponSelectCubit, CouponEntity?>(
                                  builder: (context, coupon) {
                                    return Row(
                                      children: [
                                        Text(
                                          'Coupon discount',
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                        coupon?.isPercentage() ?? false
                                            ? LabelTagWidget.productCouponTag(
                                                coupon!.discountValueLabel(),
                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    );
                                  },
                                ),
                                const Spacer(),
                                BlocSelector<TotalCubit, Total, double>(
                                  selector: (total) {
                                    return total.couponDiscount;
                                  },
                                  builder: (context, couponDiscount) {
                                    return Text(
                                      '-${couponDiscount.toStringAsFixed(2)}\$',
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
                                BlocSelector<TotalCubit, Total, double>(
                                  selector: (total) {
                                    return total.productDiscount;
                                  },
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
                                  'Token discount',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                const Spacer(),
                                BlocSelector<TotalCubit, Total, double>(
                                  selector: (total) {
                                    return total.tokenDiscount;
                                  },
                                  builder: (context, tokenDiscount) {
                                    return Text(
                                      '-${(tokenDiscount).toStringAsFixed(2)}\$',
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
                  tokenbonusTag ?? const SizedBox.shrink(),
                  const Spacer(),
                  BlocSelector<TotalCubit, Total, int>(
                    selector: (total) {
                      return total.tokenBonus;
                    },
                    builder: (context, tokenBonus) {
                      return Row(
                        children: [
                          Text(
                            '+${tokenBonus.toString()}',
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
                  BlocSelector<TotalCubit, Total, double>(
                    selector: (total) {
                      return total.total;
                    },
                    builder: (context, total) {
                      return Text(
                        '${total.toStringAsFixed(2)}\$',
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
      },
    );
  }
}
