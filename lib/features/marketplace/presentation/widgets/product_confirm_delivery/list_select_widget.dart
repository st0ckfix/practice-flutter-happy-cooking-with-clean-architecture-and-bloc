import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/cart_item.dart';

import '../../cubit/product/product_cubit.dart';

class ListSelectWidget extends StatelessWidget {
  const ListSelectWidget({super.key, required this.cartItems});

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return ProductSelectWidget(cartItem: cartItem);
        },
        separatorBuilder: (context, index) {
          return const Divider(thickness: 1);
        },
        itemCount: cartItems.length,
      ),
    );
  }
}

class ProductSelectWidget extends StatelessWidget {
  const ProductSelectWidget({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductCubit>().getProductByFoodId(foodId: cartItem.foodId)!;
    final option = product.getOption(cartItem.option);
    final hasDiscount = product.hasDiscount;
    final total = product.getTotalValue(cartItem.option);

    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      minVerticalPadding: 0,
      leading: Container(
        alignment: Alignment.topCenter,
        height: 60,
        width: 60,
        child: Image.asset(product.productThumbnail, height: 60, width: 60, fit: BoxFit.cover),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.productLabel,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Text(
                'option: ${option.title}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text(
            'quantity: ${cartItem.quantity}',
            style: const TextStyle(fontSize: 12),
          ),
          const Spacer(),
          Text(
            '${option.cost.toStringAsFixed(2)}\$',
            style: TextStyle(
              fontSize: hasDiscount ? 12 : 14,
              decoration: hasDiscount ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          if (hasDiscount)
            Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  '${total.toStringAsFixed(2)}\$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
