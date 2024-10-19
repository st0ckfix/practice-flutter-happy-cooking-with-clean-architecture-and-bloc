import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';

import '../../domain/entities/coupon_entity.dart';

class DeliveryDiscountCubit extends Cubit<double> {
  late StreamSubscription membershipStream;
  late StreamSubscription couponDeliveryStream;

  final MembershipCubit membershipCubit;
  final CouponDeliveryDiscountCubit couponDeliveryDiscountCubit;
  DeliveryDiscountCubit({
    required this.membershipCubit,
    required this.couponDeliveryDiscountCubit,
  }) : super(0.0) {
    updateDiscount(membershipCubit.state, couponDeliveryDiscountCubit.state);
    membershipStream = membershipCubit.stream.listen(
      (membership) {
        final coupon = couponDeliveryDiscountCubit.state;
        updateDiscount(membership, coupon);
      },
    );
    couponDeliveryStream = couponDeliveryDiscountCubit.stream.listen(
      (coupon) {
        final membership = membershipCubit.state;
        updateDiscount(membership, coupon);
      },
    );
  }

  void updateDiscount(Membership membership, CouponDeliveryEntity? coupon) {
    emit(membership.deliveryDiscount + (coupon?.couponValue ?? .0));
  }
}
