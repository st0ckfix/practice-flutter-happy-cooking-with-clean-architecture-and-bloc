import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/cart_item/cart_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_buying/in_buying_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/bottom_app_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/cost_review_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/delivery_address_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/delivery_option_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/invoice_details_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/list_select_widget.dart';

import '../widgets/product_confirm_delivery/discount_option_widget.dart';
import '../widgets/product_confirm_delivery/payment_option_widget.dart';

class ProductConfirmDeliveryPage extends StatelessWidget {
  const ProductConfirmDeliveryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cartItems = context.read<InBuyingBloc>().state.getListItems;
    final listWidgets = [
      const DeliveryAddressWidget(),
      const DeliveryOptionWidget(),
      ListSelectWidget(cartItems: cartItems),
      const DiscountOptionWidget(),
      const PaymentOptionWidget(),
      const InvoiceDetailsWidget(),
      const CostReviewWidget(),
    ];
    return PopScope(
      onPopInvoked: (didPop) => context.read<InBuyingBloc>().add(RemoveMultiItem()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Confirm Your Order'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 120,
              top: 0,
              left: 0,
              right: 0,
              child: ListView.separated(
                itemCount: listWidgets.length,
                itemBuilder: (_, index) => listWidgets[index],
                separatorBuilder: (_, __) => const Divider(thickness: 2, height: 5),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomAppWidget(),
            )
          ],
        ),
      ),
    );
  }
}
