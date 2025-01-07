part of 'in_recipe_bloc.dart';

class UpdateCartItem extends CartEvent {
  final CartItem cartItem;
  const UpdateCartItem({required this.cartItem});
}
