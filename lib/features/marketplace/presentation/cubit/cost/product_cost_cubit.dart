import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';

import '../../../domain/entities/cart_item.dart';

abstract class ProductCostCubit extends Cubit<ProductCost> {
  late StreamSubscription streamSubscription;
  final CartBloc cartBloc;
  final ProductCubit productCubit;
  ProductCostCubit({
    required this.cartBloc,
    required this.productCubit,
  }) : super(const ProductCost()) {
    streamSubscription = cartBloc.stream.listen((state) {
      onCalculating(state.getListItems);
    });
  }

  void onCalculating(List<CartItem> items) {
    double save = .0;
    double cost = items.isNotEmpty
        ? items.map(
            (item) {
              if (!item.isSelect) return .0;
              final food = productCubit.getProductByFoodId(foodId: item.foodId);
              if (food == null) return .0;
              save += food.getDiscountValue(item.option);
              return food.getOption(item.option).cost * item.quantity;
            },
          ).reduce(
            (value, element) => value + element,
          )
        : .0;
    print(cost);
    final newProductCost = ProductCost(subtotal: cost, save: save);

    if (state == newProductCost) return;
    emit(newProductCost);
  }

  Future<void> onClose() async {
    streamSubscription.cancel();
  }
}

class ProductCost extends Equatable {
  final double subtotal;
  final double save;

  const ProductCost({this.subtotal = .0, this.save = .0});

  bool get isEmpty {
    return subtotal == .0 && save == .0;
  }

  @override
  List<Object?> get props => [subtotal, save];
}
