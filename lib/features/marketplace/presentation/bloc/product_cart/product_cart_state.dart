part of 'product_cart_bloc.dart';

abstract class ProductCartState extends Equatable {
  const ProductCartState();
  
  @override
  List<Object> get props => [];
}

final class ProductCartInitial extends ProductCartState {}

final class ProductCartCalculating extends ProductCartState {}

final class ProductCartFinished extends ProductCartState {}