import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_manager_cubit.dart';

class ProductSelectCubit extends Cubit<ProductSelect?> {
  ProductSelectCubit() : super(null);

  void updateProduct(ProductSelect productSelect) {
    emit(productSelect);
  }
}

class ProductSelect extends Equatable {
  final Product? product;
  final int? select;

  const ProductSelect({
    required this.product,
    required this.select,
  });

  @override
  List<Object?> get props => [product, select];
}
