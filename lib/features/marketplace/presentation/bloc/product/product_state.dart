part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final List<ProductEntity>? listProducts;
  final String? error;
  const ProductState({this.listProducts, this.error});

  @override
  List<Object> get props => [listProducts!, error!];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductLoaded extends ProductState {
  const ProductLoaded(List<ProductEntity> listProducts) : super(listProducts: listProducts);
}

final class ProductError extends ProductState {
  const ProductError(String error) : super(error: error);
}
