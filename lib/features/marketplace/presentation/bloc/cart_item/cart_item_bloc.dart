import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/utils/extention.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';

part 'cart_item_event.dart';
part 'cart_item_state.dart';

abstract class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState cartState) : super(const CartState({})) {
    on<AddItem>(onAddItem);
    on<AddMultiItem>(onAddMultiItem);
    on<UpdateOption>(onUpdateOption);
    on<UpdateItems>(onUpdateItems);
    on<IncreaseQuantity>(onIncreaseQuantity);
    on<DecreaseQuantity>(onDecreaseQuantity);
    on<RemoveItem>(onRemoveItem);
    on<RemoveMultiItem>(onRemoveMultiItem);
  }

  void onUpdateItems(UpdateItems event, Emitter<CartState> emit) {
    emit(CartState({...event.items}));
  }

  void onAddItem(AddItem event, Emitter<CartState> emit) {
    final existingItem = addItem([event.cartItem]);
    emit(CartState({...state.items, existingItem.first.cartId: existingItem.first}));
  }

  List<CartItem> addItem(List<CartItem> cartItems) {
    return cartItems.indexed
        .map((e) =>
            state
                .getExistenceItemByFoodId(
                  e.$2.foodId,
                  e.$2.option,
                )
                .let(
                  (item) => item.increaseQuantity(),
                ) ??
            e.$2)
        .toList();
  }

  void onAddMultiItem(AddMultiItem event, Emitter<CartState> emit) {
    final existingListItem = addItem(event.cartItems);
    emit(CartState({...state.items, ...Map.fromEntries(existingListItem.map((e) => MapEntry(e.cartId, e)))}));
  }

  void onUpdateOption(UpdateOption event, Emitter<CartState> emit) {
    ///* Check if there a foodId and food's option had already been in cart
    final veryExistingItem = state.getExistenceItemByFoodId(event.foodId, event.option);
    if (veryExistingItem != null) {
      ///* If there a food match condition, remove the update target id
      final updatedMap = state.items..remove(event.cartId);

      ///* Then increase quantity by id that already in cart
      emit(CartState({...updatedMap, veryExistingItem.cartId: veryExistingItem.increaseQuantity()}));
    } else {
      ///* If it not a food match condition already, find that id and change its option
      final existingItem = state.getItemByCartId(event.cartId)!;
      emit(CartState({...state.items, existingItem.cartId: existingItem.copyWith(option: event.option)}));
    }
  }

  void onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    final existingItem = state.getItemByCartId(event.cartId)!;
    print('increase');
    emit(CartState({...state.items, existingItem.cartId: existingItem.increaseQuantity()}));
  }

  void onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final existingItem = state.getItemByCartId(event.cartId)!;
    print('decrease');
    emit(CartState({...state.items, existingItem.cartId: existingItem.decreaseQuantity()}));
  }

  void onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    final updatedMap = state.items..remove(event.cartId);
    if (mapEquals(state.items, updatedMap)) return;
    emit(CartState(updatedMap));
  }

  void onRemoveMultiItem(RemoveMultiItem event, Emitter<CartState> emit) {
    emit(const CartState({}));
  }
}
