import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_select_cubit.dart';
import 'package:happy_cooking/main.dart';

class CouponValueCubit extends Cubit<double> {
  StreamSubscription? inBuyingStream;
  StreamSubscription? couponStream;
  final InBuyingCostCubit inBuyingCostCubit;
  final CouponSelectCubit couponSelectCubit;
  CouponValueCubit({required this.inBuyingCostCubit, required this.couponSelectCubit}) : super(.0) {
    logg('Coupon Discount', 'Initial', '.0');
    inBuyingStream ??= inBuyingCostCubit.stream.listen((productCost) {
      final coupon = couponSelectCubit.state;
      if (coupon != null) {
        final discount = coupon.discountValue(productCost.subtotal - productCost.save);
        if (state == discount) return;
        logg('Coupon Discount', 'Update', 'Discount: $discount');
        emit(discount);
      }
    });
    couponStream ??= couponSelectCubit.stream.listen((coupon) {
      if (coupon == null) {
        if (state == .0) return;
        emit(.0);
      } else {
        final productCost = inBuyingCostCubit.state;
        final discount = coupon.discountValue(productCost.subtotal - productCost.save);
        if (state == discount) return;
        logg('Coupon Product Discount', 'Update', 'Discount: $discount');
        emit(discount);
      }
    });
  }

  Future<void> onClose() async {
    inBuyingStream?.cancel();
    couponStream?.cancel();
  }
}
