import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_recipe/in_recipe_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/select_list_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/marketplace/product_item_widget.dart';

class SelectProductWidget extends StatelessWidget {
  const SelectProductWidget({
    super.key,
    required this.productCubit,
    required this.foodId,
    required this.foodType,
    required this.cartId,
  });

  final ProductCubit productCubit;
  final String foodId;
  final String foodType;
  final String cartId;

  @override
  Widget build(BuildContext context) {
    final listProductByFoodType = productCubit.getListProductByFoodType(foodType: foodType)!.map((e) => e.$1).toList()
      ..remove(foodId)
      ..insert(0, foodId);
    int position = 0;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 70,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SelectListWidget(
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                itemInit: const [0],
                layoutBuilder: (context, index, _) {
                  final product = productCubit.getProductByFoodId(foodId: listProductByFoodType[index]);
                  return ProductItemWidget(
                    product: product!,
                    select: 0,
                    isBestSeller: listProductByFoodType.first == product.productId,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 5 / 6,
                ),
                itemCount: listProductByFoodType.length,
                onSelect: (pos, {selectList}) {
                  position = pos;
                },
                selectMode: SelectMode.single,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                addOnCheck: AddOnCheck.empty,
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 0,
            child: CustomButton(
              isOutlined: false,
              title: 'SELECT',
              onClick: () {
                context.read<InRecipeBloc>().add(
                      UpdateCartItem(
                        cartItem: CartItem(
                          cartId: cartId,
                          foodId: listProductByFoodType[position],
                        ),
                      ),
                    );
                Get.back();
              },
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: const StadiumBorder(),
            ),
          )
        ],
      ),
    );
  }
}
