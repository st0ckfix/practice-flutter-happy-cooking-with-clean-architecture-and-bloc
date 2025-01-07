part of 'coupon_cubit.dart';

abstract class CouponState extends Equatable {
  const CouponState();

  @override
  List<Object> get props => [];
}

final class AppCouponInitial extends CouponState {
  const AppCouponInitial();
}

final class AppCouponLoading extends CouponState {
  const AppCouponLoading();
}

final class AppCouponLoaded extends CouponState {
  const AppCouponLoaded() : super();
}

final class AppCouponException extends CouponState {
  const AppCouponException();
}
