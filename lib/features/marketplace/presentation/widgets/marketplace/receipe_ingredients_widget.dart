import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/recipe_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_buying/in_buying_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_recipe/in_recipe_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/all_product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/in_recipe_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/cost/product_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/recipe_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_confirm_delivery_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/in_queue_product_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/select_product_widget.dart';

import '../../../../../main.dart';

class ReceipeIngredientsWidget extends StatelessWidget {
  const ReceipeIngredientsWidget({super.key, required this.recipeEntity, this.tag});

  final RecipeEntity recipeEntity;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    logg('Receipe Ingredients Widget', 'Initial', 'Widget Build');
    final allProduct = context.read<AllProductCubit>();
    final productCubit = context.read<ProductCubit>();
    final inRecipeBloc = context.read<InRecipeBloc>();
    final listIngredient = recipeEntity.getListIngredients;
    void onPopInvoked() {
      context.read<RecipeSelectCubit>().clearRecipe();
      context.read<InRecipeBloc>().add(RemoveMultiItem());
    }

    return Scaffold(
      body: PopScope(
        onPopInvoked: (didPop) => onPopInvoked(),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 150,
                floating: false,
                pinned: true,
                leading: IconButton(
                  onPressed: () {
                    onPopInvoked();
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(bottom: 10),
                  title: Text(
                    '${recipeEntity.recipeTitle} Recipe',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  background: Hero(
                    tag: tag ?? recipeEntity.recipeId,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            recipeEntity.recipeImage,
                            height: 150,
                            width: double.maxFinite,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], stops: [.4, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: BlocBuilder<InRecipeBloc, CartState>(
            builder: (context, state) {
              final listItems = state.getListItems;
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 90,
                    left: 20,
                    right: 20,
                    child: ListView.separated(
                      itemCount: listItems.length,
                      itemBuilder: (context, index) {
                        final ingredient = listIngredient[index];
                        final productItem = allProduct.getProduct(ingredient.ingredientId);
                        final listProductByFoodType = productCubit.getListProductByFoodType(foodType: ingredient.ingredientId);
                        final cartItem = listItems[index];
                        final productEntity = productCubit.getProductByFoodId(foodId: cartItem.foodId);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${index + 1}. ${productItem.label}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '(Suggestion: ${ingredient.quantity.toString().replaceFirst('.0', '')}${ingredient.unit})',
                                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              ],
                            ),
                            InQueueProductWidget(
                              cartItem: cartItem,
                              productEntity: productEntity!,
                              isBestSeller: listProductByFoodType!.first.$1 == cartItem.foodId,
                              increaseQuantity: (){
                                inRecipeBloc.add(IncreaseQuantity(cartId: cartItem.cartId));
                              },
                              decreaseQuantity: (){
                                inRecipeBloc.add(DecreaseQuantity(cartId: cartItem.cartId));
                              },
                              updateProduct: (){
                                Get.to(
                                  () => SelectProductWidget(
                                    productCubit: productCubit,
                                    cartId: cartItem.cartId,
                                    foodId: productEntity.productId,
                                    foodType: ingredient.ingredientId,
                                  ),
                                );
                              },
                              updateOption: (option){
                                inRecipeBloc.add(UpdateOption(cartId: cartItem.cartId, foodId: cartItem.foodId, option: option));
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Divider(thickness: 1),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          title: BlocBuilder<InRecipeCostCubit, ProductCost>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  const Text('Subtotal'),
                                  const Spacer(),
                                  Text('${state.subtotal.toStringAsFixed(2)}\$'),
                                ],
                              );
                            },
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  title: 'Add To Cart',
                                  isOutlined: true,
                                  fontColor: Colors.black,
                                  onClick: () {
                                    context.read<InQueueBloc>().add(AddMultiItem(cartItems: listItems));
                                    Get.back();
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomButton(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  title: 'Buying Now',
                                  isOutlined: false,
                                  onClick: () {
                                    context.read<InBuyingBloc>().add(AddMultiItem(cartItems: listItems));
                                    Get.off(() => const ProductConfirmDeliveryPage());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
