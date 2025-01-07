import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_buying_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/main.dart';

class TokenBonusCubit extends Cubit<int> {
  final MembershipCubit membershipCubit;
  final InBuyingCostCubit inBuyingCostCubit;

  StreamSubscription? productCostStreamSubscription;
  TokenBonusCubit({
    required this.membershipCubit,
    required this.inBuyingCostCubit,
  }) : super(0) {
    logg('Token Bonus', 'Initial', 'Value: $state');
    productCostStreamSubscription ??= inBuyingCostCubit.stream.listen((productCost) {
      final tokenBonus = ((productCost.subtotal - productCost.save) * membershipCubit.state.tokenScale).round();
      logg('Token Bonus', 'Update', 'Value: $tokenBonus');
      emit(tokenBonus);
    });
  }
}
