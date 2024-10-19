import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/coupon_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';

import 'product_manager_cubit.dart';

class TotalCostCubit extends Cubit<InCountProduct> {
  late StreamSubscription inSelectProductStream;
  late StreamSubscription deliveryCostStream;

  late StreamSubscription productDiscountStream;
  late StreamSubscription deliveryDiscountStream;
  late StreamSubscription couponProductDiscountStream;
  late StreamSubscription tokenDiscountStream;

  final InSelectListProductCubit inSelectProductCubit;
  final InQueueListProductCubit inQueueListProductCubit;
  final DeliveryCostCubit deliveryCostCubit;

  final DeliveryDiscountCubit deliveryDiscountCubit;
  final CouponProductDiscountCubit couponProductDiscountCubit;
  final TokenDiscountCubit tokenDiscountCubit;

  final ProductSelectCubit productSelectCubit;

  TotalCostCubit({
    required this.couponProductDiscountCubit,
    required this.tokenDiscountCubit,
    required this.inSelectProductCubit,
    required this.inQueueListProductCubit,
    required this.deliveryCostCubit,
    required this.deliveryDiscountCubit,
    required this.productSelectCubit,
  }) : super(InCountProduct()) {
    double deliveryCost = .0;
    double deliveryDiscount = .0;
    int token = 0;
    updateList();
    inSelectProductStream = inSelectProductCubit.stream.listen((event) {
      updateList();
    });
    deliveryCostStream = deliveryCostCubit.stream.listen((deliveryOption) {
      final gap = deliveryOption.cost - deliveryCost;
      deliveryCost = deliveryOption.cost;
      emit(
        InCountProduct(
          total: state.total + gap,
          subtotal: state.subtotal,
          totalSave: state.totalSave - gap,
        ),
      );
    });
    deliveryDiscountStream = deliveryDiscountCubit.stream.listen((newDeliveryDiscount) {
      final gap = newDeliveryDiscount - deliveryDiscount;
      deliveryDiscount = newDeliveryDiscount;
      emit(
        InCountProduct(
          total: state.total - gap,
          subtotal: state.subtotal,
          totalSave: state.totalSave + gap,
        ),
      );
    });
    couponProductDiscountStream = couponProductDiscountCubit.stream.listen((state) => updateList());
    tokenDiscountStream = tokenDiscountCubit.stream.listen((newToken) {
      final gap = newToken - token;
      token = newToken;
      emit(
        InCountProduct(
          total: state.total - (gap / 100).toDouble(),
          subtotal: state.subtotal,
          totalSave: state.totalSave + (gap / 100).toDouble(),
        ),
      );
    });
  }

  void updateList() {
    log('UPDATE');
    double productSave = .0;
    double couponSave = .0;
    final couponDiscount = couponProductDiscountCubit.state;
    final deliveryCost = deliveryCostCubit.state.cost;
    final deliveryDiscount = deliveryDiscountCubit.state;
    final tokenDiscount = tokenDiscountCubit.state.toDouble();
    final inQueueListProduct = inQueueListProductCubit.state;
    log('inQueueListProduct ${inQueueListProduct}');
    final productCost = inSelectProductCubit.state.isNotEmpty
        ? inSelectProductCubit.state.map(
            (id) {
              final inQueue = inQueueListProduct.firstWhereOrNull((element) {
                return element.id == id;
              });
              if (inQueue == null) {
                log('null');
                final product = productSelectCubit.state!.product!;
                final select = productSelectCubit.state!.select!;
                final productCost = product.listClassification[select].cost;
                productSave = product.discountPercent * productCost;

                return productCost;
              } else {
                log('non null');
                final product = listProduct.firstWhere((element) => element.productId == inQueue.productId);
                final productCost = product.listClassification[inQueue.select].cost;
                productSave += product.discountPercent * productCost * inQueue.quantity;
                return productCost * inQueue.quantity;
              }
            },
          ).reduce(
            (value, element) => value + element,
          )
        : 0;

    if (couponDiscount != null && couponDiscount.couponIsPercentValue!) {
      couponSave = couponDiscount.couponValue * productCost;
    } else {
      couponSave = couponDiscount?.couponValue ?? .0;
    }

    log('productCost $productCost');
    final totalCost = productCost + (productCost == .0 ? .0 : deliveryCost - deliveryDiscount - tokenDiscount - productSave - couponSave);

    emit(
      InCountProduct(
        total: totalCost,
        subtotal: productCost.toDouble(),
        productSave: productSave,
        couponSave: couponSave,
        tokenBonus: (productCost.toDouble() - productSave - couponSave).round(),
        totalSave: tokenDiscount + productSave + couponSave,
      ),
    );
  }

  @override
  Future<void> close() {
    inSelectProductStream.cancel();
    deliveryCostStream.cancel();
    productDiscountStream.cancel();
    deliveryDiscountStream.cancel();
    couponProductDiscountStream.cancel();
    tokenDiscountStream.cancel();
    return super.close();
  }
}

class InCountProduct {
  double subtotal;
  double total;
  int tokenBonus;
  double productSave;
  double couponSave;
  double totalSave;

  InCountProduct({this.subtotal = .0, this.total = .0, this.tokenBonus = 0, this.productSave = .0, this.couponSave = .0, this.totalSave = .0});
}
