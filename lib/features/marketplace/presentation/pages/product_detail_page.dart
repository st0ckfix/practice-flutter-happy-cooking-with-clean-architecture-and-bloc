import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/product_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/in_queue/in_queue_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/nutrition/nutrition_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product/product_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/review/review_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_cart_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/label_tag_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/control_button_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/customer_rated_body_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/delivery_label_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_description_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_header_label_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_nutrition_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/provider_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/signature_dish.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/similar_product_widget.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

import '../widgets/product_detail/customer_rated_header_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController controller = PageController();
  final GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final GlobalKey globalKey = GlobalKey();
  late Function(GlobalKey) runAddToCartAnimation;

  late final String productId;
  late final ProductEntity product;
  late final int listProductLength;

  @override
  void initState() {
    super.initState();
    productId = context.read<ProductSelectCubit>().state!.productId;
    _fetchInitialData();
    _runCartAnimationOnLoad();
  }

  void _fetchInitialData() {
    context.read<ReviewCubit>().fetchListReviewsByProductId(productId);
    context.read<NutritionCubit>().fetchNutritionByProductId(productId);
    listProductLength = context.read<InQueueBloc>().state.items.length;
    product = context.read<ProductCubit>().getProductByFoodId(foodId: productId)!;
  }

  void _runCartAnimationOnLoad() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartKey.currentState?.runCartAnimation(listProductLength.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      createAddToCartAnimation: (animation) => runAddToCartAnimation = animation,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _ProductAppBar(
                cartKey: cartKey,
                thumbnail: product.productThumbnail,
              ),
            ];
          },
          body: _buildBody(product),
        ),
      ),
    );
  }

  Widget _buildBody(ProductEntity? product) {
    if (product == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final listView = [
      ProductHeaderLabelWidget(product: product),
      ControlButtonWidget(
        globalKey: globalKey,
        addToCart: () async {
          final listProductCount = context.read<InQueueBloc>().state.items.length;
          await runAddToCartAnimation(globalKey);
          await cartKey.currentState?.runCartAnimation(listProductCount.toString());
        },
      ),
      const DeliveryLabelWidget(),
      ProviderWidget(provider: product.productProviderId),
      ProductDescriptionWidget(description: product.productDescription),
      const ProductNutritionWidget(),
      SimilarProductWidget(foodType: product.productType),
      ProductSignatureDish(foodType: product.productType),
      const CustomerRatedHeaderWidget(),
      const CustomerRatedBodyWidget(),
    ];

    return CustomScrollView(slivers: [
      SliverList.separated(
        itemCount: listView.length,
        itemBuilder: (context, index) => listView[index],
        separatorBuilder: (context, index) => const Divider(height: 5, thickness: 2),
      ),
    ]);
  }
}

class _ProductAppBar extends StatelessWidget {
  final GlobalKey<CartIconKey> cartKey;
  final String thumbnail;

  const _ProductAppBar({
    required this.cartKey,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, size: 24),
      ),
      actions: [
        InkWell(
          onTap: () => Get.to(() => const ProductCartPage()),
          child: AddToCartIcon(
            key: cartKey,
            icon: const Icon(Icons.shopping_cart),
            badgeOptions: const BadgeOptions(
              active: true,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, size: 24),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  thumbnail,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  LabelTagWidget(
                    title: 'Reputaion',
                    boxColor: Colors.red,
                    textColor: Colors.white,
                  ),
                  LabelTagWidget(
                    title: 'Quality',
                    boxColor: Colors.blue,
                    textColor: Colors.white,
                  ),
                  Spacer(),
                  LabelTagWidget(
                    title: 'USA-Choice',
                    boxColor: Colors.green,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Divider(
                height: 5,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
