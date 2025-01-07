import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_enter/coupon_select_cubit.dart';

class CouponInQueueCubit extends Cubit<CouponEntity?> {
  StreamSubscription? subscription;
  final CouponSelectCubit couponSelectCubit;

  CouponInQueueCubit({required this.couponSelectCubit}) : super(null) {
    subscription ??= couponSelectCubit.stream.listen((coupon) {
      if (state?.id == coupon?.id) return;
      emit(coupon);
    });
  }

  void onClear() {
    if (state == null) return;
    emit(null);
  }

  Future<void> onClose() async {
    subscription?.cancel();
  }
}
