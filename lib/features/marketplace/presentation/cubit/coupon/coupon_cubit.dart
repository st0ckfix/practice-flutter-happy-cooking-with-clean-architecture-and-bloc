import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/coupon_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/coupon_usecase.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponState> {
  CouponUseCase appCounponUseCase;
  (List<CouponDeliveryEntity>, List<CouponProductEntity>)? listCoupon;
  CouponCubit(this.appCounponUseCase) : super(const AppCouponInitial());

  Future fetchListCoupon() async {
    emit(const AppCouponLoading());
    if (listCoupon == null) {
      final data = await appCounponUseCase();
      data.fold(
        (error) {
          emit(const AppCouponException());
        },
        (list) {
          log(list.$1.length.toString());
          log(list.$2.length.toString());
          listCoupon = list;
          emit(AppCouponLoaded(listCoupon!));
        },
      );
    } else {
      emit(AppCouponLoaded(listCoupon!));
    }
  }
}
