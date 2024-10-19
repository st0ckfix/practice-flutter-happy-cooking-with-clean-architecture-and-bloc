part of 'coupon_cubit.dart';

abstract class CouponState extends Equatable {
  final (List<CouponDeliveryEntity>, List<CouponProductEntity>)? list;
  const CouponState({this.list});

  @override
  List<Object> get props => [list!];
}

final class AppCouponInitial extends CouponState {
  const AppCouponInitial();
}

final class AppCouponLoading extends CouponState {
  const AppCouponLoading();
}

final class AppCouponLoaded extends CouponState {
  const AppCouponLoaded((List<CouponDeliveryEntity>, List<CouponProductEntity>) list) : super(list: list);
}

final class AppCouponException extends CouponState {
  const AppCouponException();
}
