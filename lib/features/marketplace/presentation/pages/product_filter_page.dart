import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_detail_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/badge_cart_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/custom_search_delegate.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/label_tag_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProductFilterPage extends StatelessWidget {
  const ProductFilterPage({super.key, required this.title, this.foodType, this.foodTag, this.foodIds});

  final String title;
  final List<(String, String)>? foodIds;
  final String? foodType;
  final String? foodTag;

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    final listProducts = productCubit.getListProductByFoodType(
          foodType: foodType,
        ) ??
        productCubit.getListProductByFoodTag(
          foodTag: foodTag,
        ) ??
        foodIds ??
        [];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    suggestionInitial: listProducts,
                  ),
                );
              },
              icon: const Icon(Icons.search)),
          const BadgeCartWidget(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
            ),
          )
        ],
      ),
      body: listProducts.isEmpty
          ? Center(
              child: Text('Found no result for: $title'),
            )
          : GridView.builder(
              cacheExtent: 1000,
              addAutomaticKeepAlives: true,
              itemCount: listProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 7.25,
              ),
              itemBuilder: (context, index) {
                final product = productCubit.getProductByFoodId(foodId: listProducts[index].$1);
                if (product == null) {
                  return const SizedBox.shrink();
                }
                final hasDiscount = product.hasDiscount;
                return InkWell(
                  onTap: () {
                    context.read<ProductSelectCubit>().updateProduct(product.productId);
                    Get.to(() => const ProductDetailPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Card(
                      surfaceTintColor: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: 180,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                  child: Image.asset(
                                    product.productThumbnail,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        color: Colors.teal,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: const Text(
                                          'XTRA',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        color: Colors.redAccent,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: const Text(
                                          'BONUS',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      LineAwesomeIcons.heart_solid,
                                    ),
                                  ),
                                ),
                                if (product.productInStock == 0)
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.white54,
                                      child: Image.asset(
                                        'assets/images/stockout_125.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 3),
                            title: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: (product.getTotalValue(0)).toStringAsFixed(2),
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: hasDiscount ? Colors.red : Colors.black,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: '\$',
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: hasDiscount ? Colors.red : Colors.black,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (hasDiscount)
                                  LabelTagWidget.discountTag(
                                    '-${(product.productDiscount * 100).toStringAsFixed(0)}%',
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productLabel,
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const RatingBar.readOnly(
                                  filledIcon: Icons.star,
                                  halfFilledIcon: Icons.star_half,
                                  emptyIcon: Icons.star_border,
                                  initialRating: 4.5,
                                  isHalfAllowed: true,
                                  maxRating: 5,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    const Icon(Icons.shopping_cart, size: 16),
                                    Text('Delivery Today', style: Theme.of(context).textTheme.titleSmall),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
