import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_cart_event.dart';
part 'product_cart_state.dart';

class ProductCartBloc extends Bloc<ProductCartEvent, ProductCartState> {
  ProductCartBloc() : super(ProductCartInitial()) {
    on<QuantityCheckChangeEvent>((event, emit) {
      
    });
    on<QuantityUnCheckChangeEvent>((event, emit) {
      
    });
    on<SingleDeleteEvent>((event, emit) {
      
    });
    on<MultiDeleteEvent>((event, emit) {
      
    });
    on<SingleCheckEvent>((event, emit) {
      
    });
    on<SingleUnCheckEvent>((event, emit) {
      
    });
    on<MultiCheckEvent>((event, emit) {
      
    });
    on<MultiUnCheckEvent>((event, emit) {
      
    });
  }
}