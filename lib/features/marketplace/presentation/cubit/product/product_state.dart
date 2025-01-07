part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  final Map<String, ProductEntity>? mapProducts;
  final String? error;
  const ProductState({this.mapProducts, this.error});

  @override
  List<Object> get props => [mapProducts!, error!];
}

final class ProductInitial extends ProductState {
  ProductInitial() : super(mapProducts: {});
}

final class ProductLoading extends ProductState {
  const ProductLoading() : super();
}

final class ProductData extends ProductState {
  const ProductData(Map<String, ProductEntity> mapProducts) : super(mapProducts: mapProducts);
}

final class ProductError extends ProductState {
  const ProductError(String error) : super(error: error);
}
