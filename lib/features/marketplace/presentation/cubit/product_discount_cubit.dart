import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';

import 'product_manager_cubit.dart';

class ProductDiscountCubit extends Cubit<double> {
  final InQueueListProductCubit<InQueueProduct> inQueueListProductCubit;
  ProductDiscountCubit({
    required this.inQueueListProductCubit,
  }) : super(0.0);

  double _calculateDiscount(InQueueProduct? inQueue, Product? product) {
    final packedPervalue = product?.listClassification[inQueue?.select ?? 0].cost ?? .0;
    return product?.discountPercent ?? .0 * packedPervalue;
  }

  (InQueueProduct?, Product?) _getProductData(String id) {
    final inQueue = inQueueListProductCubit.state.firstWhereOrNull((element) => element.id == id);
    final product = listProduct.firstWhereOrNull((element) => element.productId == inQueue?.productId);
    return (inQueue, product);
  }

  void addValueDiscount(double value) {
    emit(math.max(.0, state + value));
  }

  void addSingleDiscount(String id) {
    final currentDiscount = state;
    final productData = _getProductData(id);
    final discount = _calculateDiscount(productData.$1, productData.$2);
    emit(currentDiscount + discount);
  }

  void addMultiDiscount() {
    double totalDiscount = inQueueListProductCubit.state.fold(0.0, (accum, inQueue) {
      final product = listProduct.firstWhereOrNull((element) => element.productId == inQueue.productId);
      return accum + _calculateDiscount(inQueue, product);
    });
    emit(totalDiscount);
  }

  void removeSingleDiscount(String id) {
    final currentDiscount = state;
    final productData = _getProductData(id);
    final discount = _calculateDiscount(productData.$1, productData.$2);
    emit(math.max(.0, currentDiscount - discount));
  }

  void removeMultiDiscount() {
    emit(.0);
  }
}
