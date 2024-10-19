import 'package:chips_choice/chips_choice.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/common_widget/custom_text_field.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon/coupon_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cost_cubit.dart';

class ProductConfirmDeliveryBottomWidget extends StatelessWidget {
  const ProductConfirmDeliveryBottomWidget({super.key, required this.inCart});

  final bool inCart;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  const Text('App Discount'),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      Get.to(() => const AppDiscountFragment());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.discount_sharp),
                        const SizedBox(width: 10),
                        BlocBuilder<CouponProductDiscountCubit, CouponProductEntity?>(
                          builder: (context, coupon) {
                            if (coupon == null) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Text(
                                  coupon.couponLable,
                                  style: const TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(thickness: 2),
            IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlocBuilder<TotalCostCubit, InCountProduct>(
                      builder: (context, inCount) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(inCart ? 'Subtotal' : 'Total'),
                            Text(
                              '${(inCount.subtotal - inCount.productSave).toStringAsFixed(2)}\$',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            inCount.total == 0.0
                                ? const SizedBox.shrink()
                                : Text(
                                    'Save ${(inCart ? inCount.productSave : (inCount.totalSave + context.read<DeliveryDiscountCubit>().state)).toStringAsFixed(2)}\$',
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                          color: Colors.green,
                                        ),
                                  )
                          ],
                        );
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: CustomButton(
                          isOutlined: false,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          width: double.maxFinite,
                          fontSize: 16,
                          title: 'Order',
                          onClick: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppDiscountFragment extends StatelessWidget {
  const AppDiscountFragment({super.key});
  @override
  Widget build(BuildContext context) {
    CouponProductEntity? currentProductCoupon = context.read<CouponProductDiscountCubit>().state;
    //CouponDeliveryEntity? currentDeliverCoupon = context.read<CouponDeliveryDiscountCubit>().state;
    context.read<CouponCubit>().fetchListCoupon();
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
                      return Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10, right: 15, top: 5, bottom: 5),
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
                            child: IntrinsicWidth(
                              child: CustomButton(
                                isOutlined: false,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                title: 'Submit',
                                onClick: () {
                                  globalKey.currentState!.validate();
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<CouponCubit, CouponState>(
                    builder: (context, state) {
                      final inCount = context.read<TotalCostCubit>().state;
                      final listCounpon = state.list!.$2;
                      if (state is AppCouponLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is AppCouponLoaded) {
                        return StatefulBuilder(
                          builder: (context, stateful) {
                            return ChipsChoice<String>.single(
                              mainAxisSize: MainAxisSize.min,
                              direction: Axis.vertical,
                              wrapped: true,
                              value: currentProductCoupon?.couponId ?? '',
                              choiceBuilder: (_, i) {
                                final item = listCounpon[i];
                                final matchCondition = inCount.total <= item.couponCondition!;
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (matchCondition) return;
                                        stateful(() {
                                          currentProductCoupon = item;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 15, right: 15, top: 100),
                                        child: CouponCard(
                                          height: 120,
                                          curveAxis: Axis.vertical,
                                          curvePosition: 120,
                                          backgroundColor: Colors.white,
                                          border: currentProductCoupon?.couponId == item.couponId ? const BorderSide(width: 7, color: Color.fromARGB(255, 4, 135, 241)) : null,
                                          firstChild: Container(
                                            margin: const EdgeInsets.only(right: 1),
                                            color: const Color(0xFF368f8b),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/delivery.png',
                                                  color: Colors.white,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                const Text(
                                                  'DELIVERY',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          secondChild: Container(
                                            margin: const EdgeInsets.only(left: 1),
                                            padding: const EdgeInsets.all(15),
                                            height: double.maxFinite,
                                            color: const Color(0xffcaf3f0),
                                            child: Stack(
                                              children: [
                                                if (matchCondition) Positioned(top: 10, bottom: 10, left: 10, right: 10, child: Image.asset('assets/iamges/not_eligible.png')),
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Apply For Every Deal',
                                                      style: TextStyle(
                                                        color: Color(0xff5f716f),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      '1\$ DISCOUNT',
                                                      style: TextStyle(
                                                        color: Color(0xff328d89),
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w900,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      'Valid Till - 30 Dec 2024',
                                                      style: TextStyle(
                                                        color: Color(0xff758e8c),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10)
                                  ],
                                );
                              },
                              onChanged: (value) {},
                              choiceItems: C2Choice.listFrom<String, String>(
                                source: state.list!.$2.map((e) => e.couponId).toList(),
                                value: (index, item) => item,
                                label: (index, item) => '',
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
                  context.read<CouponProductDiscountCubit>().updateCoupon(currentProductCoupon);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
