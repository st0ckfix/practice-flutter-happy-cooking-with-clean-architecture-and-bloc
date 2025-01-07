import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';

part 'in_queue_event.dart';

///* Use in cart
class InQueueBloc extends CartBloc {
  InQueueBloc() : super(const CartState({})) {
    on<SelectAll>(onSelectAll);
    on<UnselectAll>(onUnselectAll);
    on<SelectSingle>(onSelectSingle);
    on<UnselectSingle>(onUnselectSingle);
  }

  void onSelectSingle(SelectSingle event, Emitter<CartState> emit) {
    print('select single');
    final item = state.getItemByCartId(event.cartId)!;
    emit(CartState({...state.items, item.cartId: item.select()}));
  }

  void onUnselectSingle(UnselectSingle event, Emitter<CartState> emit) {
    print('unselect single');
    final item = state.getItemByCartId(event.cartId)!;
    emit(CartState({...state.items, item.cartId: item.unselect()}));
  }

  void onSelectAll(SelectAll event, Emitter<CartState> emit) {
    print('select all');
    final updateMap = Map<String, CartItem>.fromEntries(state.items.entries.map((e) => MapEntry(e.key, e.value.select())));
    emit(CartState(updateMap));
  }

  void onUnselectAll(UnselectAll event, Emitter<CartState> emit) {
    print('unselect all');
    final updateMap = Map<String, CartItem>.fromEntries(state.items.entries.map((e) => MapEntry(e.key, e.value.unselect())));
    emit(CartState(updateMap));
  }
}
