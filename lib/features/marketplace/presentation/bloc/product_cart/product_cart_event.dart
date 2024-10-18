part of 'product_cart_bloc.dart';

abstract class ProductCartEvent extends Equatable {
  const ProductCartEvent();

  

  @override
  List<Object> get props => [];
}

final class QuantityCheckChangeEvent extends ProductCartEvent {

}

final class QuantityUnCheckChangeEvent extends ProductCartEvent {

}

final class SingleDeleteEvent extends ProductCartEvent {

}

final class MultiDeleteEvent  extends ProductCartEvent {

}

final class SingleCheckEvent  extends ProductCartEvent {

}

final class SingleUnCheckEvent  extends ProductCartEvent {

}

final class MultiCheckEvent  extends ProductCartEvent {

}

final class MultiUnCheckEvent  extends ProductCartEvent {

}