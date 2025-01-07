import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/recipe_select_cubit.dart';

import '../../../domain/entities/cart_item.dart';

part 'in_recipe_event.dart';

///* Use in recipe
class InRecipeBloc extends CartBloc {
  final RecipeSelectCubit recipeSelectCubit;
  final ProductCubit productCubit;
  StreamSubscription? streamSubscription;
  InRecipeBloc({required this.recipeSelectCubit, required this.productCubit}) : super(const CartState({})) {
    on<UpdateCartItem>(changeCartItem);
    streamSubscription ??= recipeSelectCubit.stream.listen((recipe) {
      if (recipe != null) {
        add(
          AddMultiItem(
            cartItems: recipe.getListIngredientsId.map((e) {
              return CartItem(foodId: productCubit.getListProductIdByFoodType(foodType: e)!.first, isSelect: true);
            }).toList(),
          ),
        );
      }
    });
  }
  void changeCartItem(UpdateCartItem event, Emitter emit) {
    print('update cart item');
    final existanceItem = state.getItemByCartId(event.cartItem.cartId);
    
    if (existanceItem != null && existanceItem.foodId != event.cartItem.foodId) {
      emit(CartState({...state.items, existanceItem.cartId: existanceItem.copyWith(foodId: event.cartItem.foodId)}));
    }
  }
}
