import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/main.dart';


class ProductSelectCubit extends Cubit<ProductSelect?> {
  ProductSelectCubit() : super(null) {
    logg('Product Select', 'Initial', state == null ? 'Nothing Select' : 'Label: ${state!.productId}, Option: ${state?.option}');
  }

  void updateOption(int option) {
    logg('Product Select', 'Update Option', 'Last: ${state?.option ?? 0}, New: $option');
    if (state == null || state?.option == option) return;
    emit(state!.copyWith(option: option));
  }

  void updateProduct(String productId) {
    logg('Product Select', 'Update Product', 'Id: $productId');
    emit(ProductSelect(productId: productId));
  }
}

class ProductSelect extends Equatable {
  final String productId;
  final int? option;

  const ProductSelect({
    required this.productId,
    this.option = 0,
  });

  ProductSelect copyWith({
    String? productId,
    int? option,
  }) {
    return ProductSelect(
      productId: productId ?? this.productId,
      option: option ?? this.option,
    );
  }

  @override
  List<Object?> get props => [productId, option];
}
