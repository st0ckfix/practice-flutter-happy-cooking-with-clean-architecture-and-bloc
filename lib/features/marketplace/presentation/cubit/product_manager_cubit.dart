import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductManagerCubit<T> extends Cubit<List<T>> {
  ProductManagerCubit(super.initialState);

  void insertProduct(T id) {
    final list = List<T>.from(state);
    emit(list..add(id));
  }

  void removeProduct(T id) {
    final list = List<T>.from(state);
    emit(list..remove(id));
  }

  void removeListProducts() {
    emit([]);
  }
}

class InSelectProductCubit extends ProductManagerCubit<String> {
  final InQueueListProductCubit<InQueueProduct> inQueueListProductCubit;
  InSelectProductCubit({required this.inQueueListProductCubit}) : super([]);

  void insertListProducts() {
    emit(inQueueListProductCubit.state.map((e) => e.id).toList());
  }
}

class InQueueListProductCubit<T> extends ProductManagerCubit<InQueueProduct> {
  InQueueListProductCubit() : super([]);

  void changeQuantity(String id, int quantity) {
    final updatedProducts = state.map((product) {
      if (product.id == id) {
        return product.copyWith(quantity: quantity);
      }
      return product;
    }).toList();

    emit(updatedProducts);
  }
}

class InQueueProduct extends Equatable {
  final String id;
  final String productId;
  final int select;
  final int quantity;

  const InQueueProduct({
    required this.id,
    required this.productId,
    this.select = 0,
    this.quantity = 1,
  });

  InQueueProduct copyWith({
    int? select,
    int? quantity,
  }) {
    return InQueueProduct(
      id: id,
      productId: productId,
      select: select ?? this.select,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, productId, select, quantity];
}

class Product {
  final String productId;
  final String label;
  final List<Classification> listClassification;
  final double discountPercent;

  Product({
    required this.productId,
    required this.label,
    required this.listClassification,
    this.discountPercent = 0,
  });

  factory Product.getRandomProduct() {
    final percent = <double>[.3, .2, .15, 0][Random().nextInt(4)];
    final productId = Random().nextInt(1000000).toString();
    final label = [
      'Hutao Beef: USA Choice',
      'Zhongli Chicken: Drumstick - FreeCage',
      'Ganyu Milk: 5% Fat - FreeCage',
      'Mavuika Chicken Egg: FreeCage',
      'Kokoki Tuna Fish: Fresh & Iced-Cold',
      'Kazuha Lobster Alaska: Fresh & Iced-Cold',
      'Eula Octopus: Northsea & Northwestsea',
    ][Random().nextInt(7)];
    return Product(
      productId: productId,
      label: label,
      listClassification: [
        Classification.onePacked(),
        Classification.twoPacked(),
        Classification.threePacked(),
      ],
      discountPercent: percent,
    );
  }
}

class Classification {
  final String label;
  final double cost;

  Classification({required this.label, required this.cost});

  factory Classification.onePacked() => Classification(label: '1kg Packed', cost: [4.0, 4.5][Random().nextInt(2)]);

  factory Classification.twoPacked() => Classification(label: '2kg Packed', cost: [8.0, 8.5][Random().nextInt(2)]);

  factory Classification.threePacked() => Classification(label: '3kg Packed', cost: [11.5, 12.0][Random().nextInt(2)]);
}
