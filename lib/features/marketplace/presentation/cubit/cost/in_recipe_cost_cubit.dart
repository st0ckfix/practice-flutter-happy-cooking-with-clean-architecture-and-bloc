import 'package:happy_cooking/features/marketplace/presentation/bloc/in_recipe/in_recipe_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/product_cost_cubit.dart';

class InRecipeCostCubit extends ProductCostCubit {
  InRecipeCostCubit({
    required InRecipeBloc inRecipeBloc,
    required super.productCubit,
  }) : super(cartBloc: inRecipeBloc);
}
