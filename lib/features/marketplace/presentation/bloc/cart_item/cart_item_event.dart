part of 'cart_item_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class UpdateItems extends CartEvent {
  final Map<String, CartItem> items;

  const UpdateItems({required this.items});

  @override
  List<Object?> get props => [items];
}

class AddItem extends CartEvent {
  final CartItem cartItem;

  const AddItem({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class AddMultiItem extends CartEvent {
  final List<CartItem> cartItems;

  const AddMultiItem({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}

class RemoveItem extends CartEvent {
  final String cartId;

  const RemoveItem({required this.cartId});

  @override
  List<Object?> get props => [cartId];
}

class IncreaseQuantity extends CartEvent {
  final String cartId;

  const IncreaseQuantity({required this.cartId});
}

class DecreaseQuantity extends CartEvent {
  final String cartId;

  const DecreaseQuantity({required this.cartId});
}

class UpdateOption extends CartEvent {
  final String cartId;
  final String foodId;
  final int option;

  const UpdateOption({required this.cartId, required this.foodId, required this.option});
}

class UpdateSelect extends CartEvent {
  final String cartId;

  const UpdateSelect({required this.cartId});
}

class RemoveMultiItem extends CartEvent {}
