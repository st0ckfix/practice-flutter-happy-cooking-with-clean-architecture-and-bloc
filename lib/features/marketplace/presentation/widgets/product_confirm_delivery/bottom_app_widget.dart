import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/common_widget/custom_text_field.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon/coupon_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_in_queue_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/bottom_app_review.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/expandable_list_widget.dart';

class BottomAppWidget extends StatelessWidget {
  const BottomAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 5,
        child: Container(
          color: Colors.white,
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: BlocBuilder<TotalCubit, Total>(
                builder: (context, total) {
                  return Column(
                    children: [
                      const BottomAppCoupon(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Divider(height: 1, thickness: 1),
                      ),
                      BottomAppReview(
                        total: total.total,
                        save: total.fullSave,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppCoupon extends StatelessWidget {
  const BottomAppCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Coupon'),
        const Spacer(),
        InkWell(
          onTap: () async {
            Get.to(() => const AppDiscountFragment());
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      BlocBuilder<CouponSelectCubit, CouponEntity?>(
                        builder: (context, coupon) {
                          return Text(
                            (coupon?.label ?? ''),
                            style: const TextStyle(fontSize: 12, color: Color(0xFF368f8b), fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios, size: 12),
            ],
          ),
        )
      ],
    );
  }
}

class AppDiscountFragment extends StatelessWidget {
  const AppDiscountFragment({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('App Discount Coupon'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 60,
            right: 0,
            left: 0,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (context) {
                      GlobalKey<FormState> globalKey = GlobalKey<FormState>();
                      return SizedBox(
                        height: 42,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.only(left: 10, right: 15),
                                child: Form(
                                  key: globalKey,
                                  child: IntrinsicWidth(
                                    child: CustomTextField(
                                      hintText: 'Enter your discount coupon',
                                      validator: ValidationBuilder().required().build(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: CustomButton(
                                  isOutlined: false,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  title: 'Submit',
                                  onClick: () {
                                    globalKey.currentState!.validate();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: BlocBuilder<CouponCubit, CouponState>(
                      builder: (context, state) {
                        if (state is AppCouponLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is AppCouponLoaded) {
                          return ProductListCouponWidget(
                            matchConditionList: context.read<CouponCubit>().matchConditionList,
                            unmatchConditionList: context.read<CouponCubit>().unmatchConditionList,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                width: double.maxFinite,
                isOutlined: false,
                title: 'Confirm',
                onClick: () {
                  context.read<CouponSelectCubit>().updateCoupon(context.read<CouponInQueueCubit>().state);
                  Get.back();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProductListCouponWidget extends StatelessWidget {
  const ProductListCouponWidget({
    super.key,
    required this.matchConditionList,
    required this.unmatchConditionList,
  });

  final List<CouponEntity> matchConditionList;
  final List<CouponEntity> unmatchConditionList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponSelectCubit, CouponEntity?>(
      builder: (context, couponEntity) {
        final combineList = List<CouponEntity>.from(matchConditionList)..addAll(unmatchConditionList);
        final List<Widget> listWidgets = [];
        for (final coupon in combineList) {
          listWidgets.add(CouponWidget(coupon: coupon));
        }

        return ExpandableListWidget(
          listWidget: listWidgets,
          collapsePositions: const [0, 1, 2],
        );
      },
    );
  }
}

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key, required this.coupon});

  final CouponEntity coupon;

  @override
  Widget build(BuildContext context) {
    final cost = context.read<InBuyingCostCubit>().state;
    final isSatisfy = coupon.condition!.isSatisfied(orderValue: cost.subtotal - cost.save);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width * .9,
      child: BlocSelector<CouponInQueueCubit, CouponEntity?, bool>(
        selector: (state) {
          return state?.id == coupon.id;
        },
        builder: (context, isInQueue) {
          return CouponCard(
            height: 100,
            curveAxis: Axis.vertical,
            curvePosition: 100,
            backgroundColor: Colors.white,
            border: isInQueue ? const BorderSide(width: 7, color: Colors.blue) : null,
            firstChild: Container(
              foregroundDecoration: !isSatisfy ? BoxDecoration(color: Colors.grey.withOpacity(.7)) : null,
              margin: const EdgeInsets.only(right: 1),
              color: const Color(0xFF368f8b),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/discount.png',
                    color: Colors.white,
                    height: 50,
                    width: 50,
                  ),
                  const Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            secondChild: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.only(left: 1),
                    padding: const EdgeInsets.all(10),
                    height: double.maxFinite,
                    foregroundDecoration: !isSatisfy ? BoxDecoration(color: Colors.grey.withOpacity(.7)) : null,
                    color: const Color(0xffcaf3f0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coupon.subtitle,
                          style: const TextStyle(
                            color: Color(0xff5f716f),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          coupon.title,
                          style: const TextStyle(
                            color: Color(0xff5f716f),
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Valid Till - 30 Dec 2024',
                          style: TextStyle(
                            color: Color(0xff758e8c),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isSatisfy)
                  Positioned(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Image.asset(
                      'assets/images/not_eligible.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
