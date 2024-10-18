import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/app_coupon_entity.dart';

import 'product_manager_cubit.dart';

abstract class DiscountValue<T> extends Cubit<T> {
  DiscountValue(super.initialState);

  void updateValue(T newValue) {
    emit(newValue);
  }
}

class AppDiscountCubit extends DiscountValue<AppCouponEntity?> {
  AppDiscountCubit() : super(null);

  @override
  void updateValue(AppCouponEntity? newValue) {
    if (state?.id == newValue?.id) {
      return;
    }
    emit(newValue);
  }
}

class DeliveryCostCubit extends DiscountValue<DeliveryOption> {
  DeliveryCostCubit() : super(DeliveryOption.today());
}

class DeliveryOption {
  final String label;
  final String message;
  final double cost;

  DeliveryOption({required this.label, required this.message, required this.cost});

  factory DeliveryOption.today() => DeliveryOption(label: 'Delivery Today', message: 'Delivery: Today, before 18:00', cost: 3.5);

  factory DeliveryOption.later() => DeliveryOption(label: 'Delivery Later', message: 'Delivery: Later, before 2 days later', cost: 1.5);
}

class ProductSelectCubit extends DiscountValue<ProductSelect?> {
  ProductSelectCubit() : super(null);
}

class ProductSelect extends Equatable {
  final Product? product;
  final int? select;

  const ProductSelect({
    required this.product,
    required this.select,
  });

  @override
  List<Object?> get props => [product, select];
}

class DeliveryDiscountCubit extends DiscountValue<double> {
  DeliveryDiscountCubit() : super(0.0);
}

class SaleDiscountCubit extends DiscountValue<double> {
  SaleDiscountCubit() : super(2.5);
}

class TokenDiscountCubit extends DiscountValue<double> {
  TokenDiscountCubit() : super(0.0);
}
