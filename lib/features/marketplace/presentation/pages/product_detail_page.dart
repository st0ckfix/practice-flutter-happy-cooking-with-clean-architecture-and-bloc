import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_cart_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/control_button_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/customer_rated_body_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/delivery_label_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/delivery_location_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/insurance_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/more_service_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_description_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_detail_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_header_label_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/product_offer_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/provider_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

import '../cubit/product_manager_cubit.dart';
import '../widgets/product_detail/customer_rated_header_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  PageController controller = PageController();
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final GlobalKey globalKey = GlobalKey();
  late Function(GlobalKey) runAddToCartAnimation;
  final colors = [Colors.red, Colors.blue, Colors.green];

  @override
  void initState() {
    super.initState();
    int listProduct = context.read<InQueueListProductCubit<InQueueProduct>>().state.length;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartKey.currentState!.runCartAnimation((listProduct).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
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
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 24,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      PageView.builder(
                        controller: controller,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 400,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: colors[index],
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            count: 3,
                            controller: controller,
                            effect: const SlideEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                            ),
                            onDotClicked: (index) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              const ProductOfferWidget(),
              const Divider(height: 5, thickness: 5),
              const ProductHeaderLabelWidget(),
              const Divider(height: 5, thickness: 5),
              ControlButtonWidget(
                globalKey: globalKey,
                addToCart: () async {
                  int listProduct = context.read<InQueueListProductCubit<InQueueProduct>>().state.length;
                  await runAddToCartAnimation(globalKey);
                  await cartKey.currentState!.runCartAnimation((listProduct).toString());
                },
              ),
              const Divider(height: 5, thickness: 5),
              const DeliveryLocationWidget(),
              const Divider(height: 5, thickness: 5),
              const DeliveryLabelWidget(),
              const Divider(height: 5, thickness: 5),
              const InsuranceWidget(),
              const Divider(height: 5, thickness: 5),
              const ProviderWidget(),
              const Divider(height: 5, thickness: 5),
              const MoreServiceWidget(),
              const Divider(height: 5, thickness: 5),
              const ProductDetailWidget(),
              const Divider(height: 5, thickness: 5),
              const ProductDescriptionWidget(),
              const Divider(height: 5, thickness: 5),
              const CustomerRatedHeaderWidget(),
              const Divider(height: 5, thickness: 5),
              const CustomerRatedBodyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
