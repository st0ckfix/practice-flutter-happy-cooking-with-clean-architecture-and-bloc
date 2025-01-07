part of 'cart_item_bloc.dart';

class CartState extends Equatable {
  final Map<String, CartItem> items;

  const CartState(this.items);

  ///* get full list items
  List<CartItem> get getListItems => items.values.toList();

  ///* get selected items
  List<CartItem> get getSelectedItems => items.values.where((element) => element.isSelect).toList();

  ///* get item by cart id
  CartItem? getItemByCartId(String cartId) => items[cartId];

  ///* get item by matching food id
  CartItem? getItemByFoodId(String foodId) => items.values.toList().firstWhereOrNull((element) => element.foodId == foodId);

  ///* get item by matching food id and food's option
  CartItem? getExistenceItemByFoodId(String foodId, int option) => items.values.toList().firstWhereOrNull((element) => element.foodId == foodId && element.option == option);

  ///* check if all items is select
  bool get isAllSelected => !items.values.any((element) => !element.isSelect);

  @override
  List<Object?> get props => [items];

}
