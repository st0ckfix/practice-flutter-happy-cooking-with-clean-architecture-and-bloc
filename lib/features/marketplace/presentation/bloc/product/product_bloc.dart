import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/product_usecase.dart';

import '../../../domain/entities/product_entity.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductUseCase productUseCase;
  List<ProductEntity>? listProducts = [];
  ProductBloc(this.productUseCase) : super(const ProductInitial()) {
    on<FetchListProductEvent>((event, emit) async {
      emit(const ProductLoading());
      final eitherProduct = await productUseCase.call(params: 'beef_chuck');
      eitherProduct.fold(
        (error) {
          emit(ProductError(error));
        },
        (data) {
          listProducts ??= data;
          emit(ProductLoaded(listProducts!));
        },
      );
    });
    on<QueryProductEvent>((event, emit) async {
      
    });
  }
}
