import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/main.dart';

class MembershipCubit extends Cubit<Membership> {
  MembershipCubit(super.initialState) {
    logg('Membership', 'Initial', state.memberType.toString());
  }

  String membershipDiscountLabel() {
    return '${state.deliveryDiscount.toStringAsFixed(2)}\$';
  }

  String membershipTokenBonusLabel() {
    return 'x${state.tokenScale}';
  }
}

enum MemberType { none, gold, platinum, diamond }

class Membership {
  MemberType memberType;
  double deliveryDiscount;
  double tokenScale;
  int tokenAllow;

  Membership({
    required this.memberType,
    required this.deliveryDiscount,
    required this.tokenScale,
    required this.tokenAllow,
  });

  factory Membership.none() {
    return Membership(
      memberType: MemberType.none,
      deliveryDiscount: .0,
      tokenScale: 1.0,
      tokenAllow: 50,
    );
  }

  factory Membership.gold() {
    return Membership(
      memberType: MemberType.gold,
      deliveryDiscount: .5,
      tokenScale: 1.2,
      tokenAllow: 100,
    );
  }

  factory Membership.platinum() {
    return Membership(
      memberType: MemberType.platinum,
      deliveryDiscount: 1.0,
      tokenScale: 1.5,
      tokenAllow: 200,
    );
  }

  factory Membership.diamond() {
    return Membership(
      memberType: MemberType.diamond,
      deliveryDiscount: 2.0,
      tokenScale: 2.0,
      tokenAllow: 500,
    );
  }
}
