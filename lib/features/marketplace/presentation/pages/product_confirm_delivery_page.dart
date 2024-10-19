import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/cost_review_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/delivery_address_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/delivery_method_and_product_summary_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/discount_options_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/invoice_details_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/payment_options_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_confirm_delivery/product_confirm_delivery_bottom_widget.dart';

import '../cubit/product_manager_cubit.dart';

class ProductConfirmDeliveryPage extends StatelessWidget {
  const ProductConfirmDeliveryPage({super.key, this.select});
  final int? select;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (select != null) {
          context.read<InSelectListProductCubit>().removeListProducts();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Confirm Your Order'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 130,
              top: 0,
              left: 0,
              right: 0,
              child: ListView(children: [
                const DeliveryAddressWidget(),
                const Divider(thickness: 5, height: 2),
                DeliveryMethodAndProductSummaryWidget(select: select),
                const Divider(thickness: 5, height: 2),
                const DiscountOptionsWidget(),
                const Divider(thickness: 5, height: 2),
                const PaymentOptionsWidget(),
                const Divider(thickness: 5, height: 2),
                const InvoiceDetailsWidget(),
                const Divider(thickness: 5, height: 2),
                const CostReviewWidget(),
              ]),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ProductConfirmDeliveryBottomWidget(inCart: false),
            )
          ],
        ),
      ),
    );
  }
}
