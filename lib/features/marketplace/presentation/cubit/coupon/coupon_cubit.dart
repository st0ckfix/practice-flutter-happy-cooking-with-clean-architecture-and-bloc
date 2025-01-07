import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/coupon_usecase.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/product_cost_cubit.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponUseCase appCouponUseCase;
  InBuyingCostCubit inBuyingCostCubit;
  late StreamSubscription streamSubscription;
  List<CouponEntity> matchConditionList = [];
  List<CouponEntity> unmatchConditionList = [];
  CouponCubit({required this.appCouponUseCase, required this.inBuyingCostCubit}) : super(const AppCouponInitial()) {
    streamSubscription = inBuyingCostCubit.stream.listen(
      (event) => setData(
        matchConditionList..addAll(unmatchConditionList),
        event,
      ),
    );
  }

  Future fetchListCoupon() async {
    emit(const AppCouponLoading());
    if (matchConditionList.isEmpty && unmatchConditionList.isEmpty) {
      final data = await appCouponUseCase();
      data.fold(
        (error) {
          emit(const AppCouponException());
        },
        (list) {
          setData(list, null);
          emit(const AppCouponLoaded());
        },
      );
    } else {
      emit(const AppCouponLoaded());
    }
  }

  void setData(List<CouponEntity> list, ProductCost? productCost) {
    if ((productCost ?? inBuyingCostCubit.state).isEmpty) {
      unmatchConditionList = list;
      matchConditionList = [];
    } else {
      final order = (productCost ?? inBuyingCostCubit.state).subtotal - (productCost ?? inBuyingCostCubit.state).save;
      for (final coupon in list) {
        if (coupon.condition!.isSatisfied(orderValue: order)) {
          matchConditionList.add(coupon);
        } else {
          unmatchConditionList.add(coupon);
        }
      }
      matchConditionList.sort(
        (couponA, couponB) => couponB.discountValue(order).compareTo(
              couponA.discountValue(order),
            ),
      );
      unmatchConditionList.sort(
        (couponA, couponB) => couponB.discountValue(order).compareTo(
              couponA.discountValue(order),
            ),
      );
    }
  }
}
