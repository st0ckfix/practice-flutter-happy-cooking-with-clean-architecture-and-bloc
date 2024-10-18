import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/another_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';

import 'discount_value_cubit.dart';
import 'product_manager_cubit.dart';

class TotalCostCubit extends Cubit<InCountProduct> {
  late StreamSubscription deliveryCostSub;
  late StreamSubscription anotherDiscountSub;
  late StreamSubscription deliveryDiscountSub;
  late StreamSubscription productSub;

  final InSelectProductCubit inSelectProductCubit;
  final InQueueListProductCubit inQueueListProductCubit;
  final DeliveryCostCubit deliveryCostCubit;
  final DeliveryDiscountCubit deliveryDiscountCubit;
  final AnotherDiscountCubit anotherDiscountCubit;

  final ProductSelectCubit productSelectCubit;

  TotalCostCubit({
    required this.inSelectProductCubit,
    required this.inQueueListProductCubit,
    required this.deliveryCostCubit,
    required this.deliveryDiscountCubit,
    required this.anotherDiscountCubit,
    required this.productSelectCubit,
  }) : super(InCountProduct()) {
    updateTotal();
    productSub = inSelectProductCubit.stream.listen((event) {
      updateTotal();
    });
    deliveryCostSub = deliveryCostCubit.stream.listen((event) {
      updateTotal();
    });
    anotherDiscountSub = deliveryDiscountCubit.stream.listen((event) {
      updateTotal();
    });
    deliveryDiscountSub = anotherDiscountCubit.stream.listen((event) {
      updateTotal();
    });
  }

  void updateTotal() {
    final deliveryCost = deliveryCostCubit.state;
    final deliveryDiscount = deliveryDiscountCubit.state;
    final anotherDiscount = anotherDiscountCubit.state;
    final inQueueListProduct = inQueueListProductCubit.state;
    final productCost = inSelectProductCubit.state.isNotEmpty
        ? inSelectProductCubit.state.map(
            (id) {
              final inQueue = inQueueListProduct.firstWhereOrNull((element) {
                return element.id == id;
              });
              if (inQueue == null) {
                final product = productSelectCubit.state!.product;
                final select = productSelectCubit.state!.select;
                return product!.listClassification[select!].cost;
              } else {
                final product = listProduct.firstWhere((element) => element.productId == inQueue.productId);
                return product.listClassification[inQueue.select].cost * inQueue.quantity;
              }
            },
          ).reduce(
            (value, element) => value + element,
          )
        : 0;

    final totalCost = productCost + (productCost == .0 ? .0 : deliveryCost.cost - deliveryDiscount - anotherDiscount);
    log('==================');
    log('SUBTOTAL: $productCost');
    log('DELIVERY: ${deliveryCost.cost}');
    log('DELIDISC: $deliveryDiscount');
    log('ANOTHERD: $anotherDiscount');
    log('TOTAL: $totalCost');
    log('==================');
    emit(InCountProduct(total: totalCost, subtotal: productCost.toDouble()));
  }

  @override
  Future<void> close() {
    deliveryCostSub.cancel();
    anotherDiscountSub.cancel();
    deliveryDiscountSub.cancel();
    return super.close();
  }
}

class InCountProduct {
  double subtotal;
  double total;

  InCountProduct({this.subtotal = .0, this.total = .0});
}
