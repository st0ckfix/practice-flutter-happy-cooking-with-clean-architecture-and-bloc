import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class CartItem extends Equatable {
  final String cartId;
  final String foodId;
  final int option;
  final int quantity;
  final bool isSelect;

  CartItem({
    String? cartId,
    required this.foodId,
    int? option,
    int? quantity,
    bool? isSelect,
  })  : cartId = cartId ?? const Uuid().v4(),
        option = option ?? 0,
        quantity = quantity ?? 1,
        isSelect = isSelect ?? false;

  CartItem copyWith({
    String? foodId,
    int? option,
    int? quantity,
    bool? isSelect,
  }) {
    return CartItem(
      cartId: cartId,
      foodId: foodId ?? this.foodId,
      option: option ?? this.option,
      quantity: quantity ?? this.quantity,
      isSelect: isSelect ?? this.isSelect,
    );
  }

  CartItem increaseQuantity() => copyWith(quantity: quantity + 1);

  CartItem decreaseQuantity() => copyWith(quantity: quantity > 1 ? quantity - 1 : 1);

  CartItem select() => copyWith(isSelect: true);

  CartItem unselect() => copyWith(isSelect: false);

  @override
  List<Object?> get props => [foodId, option, quantity, isSelect];
}
