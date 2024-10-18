import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_detail_fragment.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_detail_list_widget.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        minVerticalPadding: 10,
        title: const Text('Product Detail'),
        subtitle: Column(
          children: [
            const ProductDetailListWidget(),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () => Get.to(() => const ProductDetailFragment()),
                  child: const Text(
                    'See All',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
