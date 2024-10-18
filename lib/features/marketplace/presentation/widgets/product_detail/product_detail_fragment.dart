import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_detail_list_widget.dart';

class ProductDetailFragment extends StatelessWidget {
  const ProductDetailFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        title: const Text('Product Details'),
      ),
      body: const SingleChildScrollView(child: ProductDetailListWidget()),
    );
  }
}
