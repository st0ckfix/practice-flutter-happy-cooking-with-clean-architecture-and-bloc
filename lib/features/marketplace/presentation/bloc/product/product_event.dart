part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  final String? marketId;
  final String? productId;
  const ProductEvent({this.marketId, this.productId});

  @override
  List<Object> get props => [marketId!, productId!];
}

final class FetchListProductEvent extends ProductEvent {
  const FetchListProductEvent() : super();
}

final class FilterListProductEvent extends ProductEvent {
  const FilterListProductEvent(String marketId) : super(marketId: marketId);
} 

final class QueryProductEvent extends ProductEvent {
  const QueryProductEvent(String productId) : super(productId: productId);
}
