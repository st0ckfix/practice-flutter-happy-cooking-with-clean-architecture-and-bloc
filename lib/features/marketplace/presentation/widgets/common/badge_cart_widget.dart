import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_cart_page.dart';

class BadgeCartWidget extends StatelessWidget {
  const BadgeCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: BlocBuilder<InQueueBloc, CartState>(
        builder: (context, state) {
          return Text(
            state.items.length.toString(),
            style: const TextStyle(color: Colors.white),
          );
        },
      ),
      child: InkWell(
        onTap: () => Get.to(() => const ProductCartPage()),
        child: const Icon(
          Icons.shopping_cart_outlined,
        ),
      ),
    );
  }
}
