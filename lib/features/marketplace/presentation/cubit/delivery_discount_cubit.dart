import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';

class DeliveryDiscountCubit extends Cubit<double> {
  StreamSubscription? membershipStream;
  final MembershipCubit membershipCubit;
  DeliveryDiscountCubit({
    required this.membershipCubit,
  }) : super(.0) {
    updateDiscount(membershipCubit.state.deliveryDiscount);
    membershipStream ??= membershipCubit.stream.listen(
      (membership) {
        updateDiscount(membership.deliveryDiscount);
      },
    );
  }

  void updateDiscount(double discount) {
    emit(discount);
  }

  Future<void> onClear() async {
    membershipStream?.cancel();
  }
}
