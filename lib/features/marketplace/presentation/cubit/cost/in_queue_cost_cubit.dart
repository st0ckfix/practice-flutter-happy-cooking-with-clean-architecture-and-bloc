import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';

import 'product_cost_cubit.dart';

class InQueueCostCubit extends ProductCostCubit {
  InQueueCostCubit({
    required InQueueBloc inQueueBloc,
    required super.productCubit,
  }) : super(cartBloc: inQueueBloc);
}
