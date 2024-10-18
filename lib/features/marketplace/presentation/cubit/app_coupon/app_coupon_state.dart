part of 'app_coupon_cubit.dart';

abstract class AppCouponState extends Equatable {
  final List<AppCouponEntity>? list;
  const AppCouponState({this.list});

  @override
  List<Object> get props => [list!];
}

final class AppCouponInitial extends AppCouponState {
  const AppCouponInitial();
}

final class AppCouponLoading extends AppCouponState {
  const AppCouponLoading();
}

final class AppCouponLoaded extends AppCouponState {
  const AppCouponLoaded(List<AppCouponEntity> list) : super(list: list);
}

final class AppCouponException extends AppCouponState {
  const AppCouponException();
}
