import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/main.dart';

class CouponSelectCubit extends Cubit<CouponEntity?> {
  StreamSubscription? subscription;
  final InBuyingCostCubit inBuyingCostCubit;
  CouponSelectCubit({required this.inBuyingCostCubit}) : super(null) {
    logg('Coupon Display', 'Initial', 'Empty');
    subscription ??= inBuyingCostCubit.stream.listen((productCost) {
      if (state != null) {
        if (state!.condition!.isSatisfied(orderValue: (productCost.subtotal - productCost.save))) {
          logg('Coupon Display', 'Failed', 'Not Satisfied');
          return;
        } else {
          updateCoupon(null);
        }
      }
    });
  }

  void updateCoupon(CouponEntity? coupon) {
    logg('Coupon Display', 'Update', coupon?.toString() ?? 'Null');
    emit(coupon);
  }
}
