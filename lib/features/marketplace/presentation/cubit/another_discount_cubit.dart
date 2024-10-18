import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_discount_cubit.dart';

import 'discount_value_cubit.dart';

class AnotherDiscountCubit extends Cubit<double> {
  late StreamSubscription saleDiscountSub;
  late StreamSubscription appDiscountSub;
  late StreamSubscription tokenDiscountSub;
  late StreamSubscription productDiscountSub;

  final ProductDiscountCubit productDiscountCubit;
  final SaleDiscountCubit saleDiscountCubit;
  final AppDiscountCubit appDiscountCubit;
  final TokenDiscountCubit tokenDiscountCubit;

  AnotherDiscountCubit({
    required this.productDiscountCubit,
    required this.saleDiscountCubit,
    required this.appDiscountCubit,
    required this.tokenDiscountCubit,
  }) : super(0.0) {
    updateAnotherDiscount();
    saleDiscountSub = saleDiscountCubit.stream.listen((state) {
      updateAnotherDiscount();
    });
    appDiscountSub = appDiscountCubit.stream.listen((state) {
      updateAnotherDiscount();
    });
    tokenDiscountSub = tokenDiscountCubit.stream.listen((state) {
      updateAnotherDiscount();
    });
    productDiscountSub = productDiscountCubit.stream.listen((event) {
      updateAnotherDiscount();
    });
  }

  void updateAnotherDiscount() {
    final appDiscount = appDiscountCubit.state?.cost ?? 0.0;
    final saleDiscount = saleDiscountCubit.state;
    final tokenDiscount = tokenDiscountCubit.state;
    final productDiscount = productDiscountCubit.state;
    final anotherDiscount = appDiscount + saleDiscount + tokenDiscount + productDiscount;
    emit(anotherDiscount);
  }

  @override
  Future<void> close() {
    saleDiscountSub.cancel();
    appDiscountSub.cancel();
    tokenDiscountSub.cancel();
    productDiscountSub.cancel();
    return super.close();
  }
}
