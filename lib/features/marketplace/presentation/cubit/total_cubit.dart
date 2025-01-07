import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_value_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_bonus_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';
import 'package:happy_cooking/main.dart';

final class TotalCubit extends Cubit<Total> {
  StreamSubscription? productStreamSubscription;
  StreamSubscription? deliveryStreamSubscription;
  StreamSubscription? deliveryDiscountStreamSubscription;
  StreamSubscription? couponDiscountStreamSubscription;
  StreamSubscription? tokenDiscountStreamSubscription;

  final InBuyingCostCubit productCostCubit;
  final DeliveryCostCubit deliveryCostCubit;
  final DeliveryDiscountCubit deliveryDiscountCubit;
  final TokenBonusCubit tokenBonusCubit;
  final TokenDiscountCubit tokenDiscountCubit;
  final CouponValueCubit couponValueCubit;

  TotalCubit({
    required this.productCostCubit,
    required this.deliveryCostCubit,
    required this.deliveryDiscountCubit,
    required this.tokenDiscountCubit,
    required this.tokenBonusCubit,
    required this.couponValueCubit,
  }) : super(const Total()) {
    updateTotal(state.copyWith(deliveryCost: deliveryCostCubit.state.cost, deliveryDiscount: deliveryDiscountCubit.state));
    productStreamSubscription ??= productCostCubit.stream.listen((productCost) {
      updateTotal(state.copyWith(subtotal: productCost.subtotal, tokenBonus: tokenBonusCubit.state, productDiscount: productCost.save));
    });
    deliveryStreamSubscription ??= deliveryCostCubit.stream.listen((deliveryOption) {
      updateTotal(state.copyWith(deliveryCost: deliveryOption.cost));
    });
    deliveryDiscountStreamSubscription ??= deliveryDiscountCubit.stream.listen((deliveryDiscount) {
      updateTotal(state.copyWith(deliveryDiscount: deliveryDiscount));
    });
    couponDiscountStreamSubscription ??= couponValueCubit.stream.listen((couponDiscount) {
      updateTotal(state.copyWith(couponDiscount: couponDiscount));
    });
    tokenDiscountStreamSubscription ??= tokenDiscountCubit.stream.listen((token) {
      updateTotal(state.copyWith(tokenDiscount: (token / 100).toDouble()));
    });
  }

  void updateTotal(Total totalClass) {
    final total = totalClass.subtotal + totalClass.deliveryCost - totalClass.deliveryDiscount - totalClass.productDiscount - totalClass.couponDiscount - totalClass.tokenDiscount;
    final anotherSave = totalClass.productDiscount + totalClass.couponDiscount + totalClass.tokenDiscount;
    final fullSave = anotherSave + min(totalClass.deliveryCost, totalClass.deliveryDiscount);
    final finalTotalClass = totalClass.copyWith(total: total, anotherSave: anotherSave, fullSave: fullSave);
    if (totalClass == finalTotalClass) return;

    logg('Total', 'Update', 'Total: $total, Another Save: $anotherSave, Full Save: $fullSave');
    emit(finalTotalClass);
  }

  Future<void> onClose() async {
    productStreamSubscription?.cancel();
    deliveryStreamSubscription?.cancel();
    deliveryDiscountStreamSubscription?.cancel();
    couponDiscountStreamSubscription?.cancel();
    tokenDiscountStreamSubscription?.cancel();
  }
}

final class Total extends Equatable {
  final double subtotal;
  final double deliveryCost;
  final double deliveryDiscount;
  final double productDiscount;
  final double couponDiscount;
  final double tokenDiscount;
  final int tokenBonus;
  final double total;
  final double anotherSave;
  final double fullSave;

  const Total({
    this.subtotal = .0,
    this.deliveryCost = .0,
    this.deliveryDiscount = .0,
    this.productDiscount = .0,
    this.couponDiscount = .0,
    this.tokenDiscount = .0,
    this.tokenBonus = 0,
    this.total = 0,
    this.anotherSave = .0,
    this.fullSave = .0,
  });

  Total copyWith({
    double? subtotal,
    double? deliveryCost,
    double? deliveryDiscount,
    double? productDiscount,
    double? couponDiscount,
    double? tokenDiscount,
    int? tokenBonus,
    double? total,
    double? anotherSave,
    double? fullSave,
  }) {
    return Total(
      subtotal: subtotal ?? this.subtotal,
      deliveryCost: deliveryCost ?? this.deliveryCost,
      deliveryDiscount: deliveryDiscount ?? this.deliveryDiscount,
      productDiscount: productDiscount ?? this.productDiscount,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      tokenDiscount: tokenDiscount ?? this.tokenDiscount,
      tokenBonus: tokenBonus ?? this.tokenBonus,
      total: total ?? this.total,
      anotherSave: anotherSave ?? this.anotherSave,
      fullSave: fullSave ?? this.fullSave,
    );
  }

  @override
  List<Object?> get props => [
        subtotal,
        deliveryCost,
        deliveryDiscount,
        productDiscount,
        couponDiscount,
        tokenDiscount,
        tokenBonus,
        total,
        anotherSave,
        fullSave,
      ];
}
