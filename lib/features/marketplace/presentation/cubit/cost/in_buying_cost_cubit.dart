import 'package:happy_cooking/features/marketplace/presentation/bloc/in_buying/in_buying_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/product_cost_cubit.dart';

class InBuyingCostCubit extends ProductCostCubit {
  InBuyingCostCubit({
    required InBuyingBloc inBuyingBloc,
    required super.productCubit,
  }) : super(cartBloc: inBuyingBloc);
}
