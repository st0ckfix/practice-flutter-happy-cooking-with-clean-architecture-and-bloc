import 'dart:math' as math;

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/product/product_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_cart_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_detail_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../cubit/product_manager_cubit.dart';

class ProductFilterPage extends StatefulWidget {
  const ProductFilterPage({super.key, required this.tagFilter});

  final String tagFilter;

  @override
  State<ProductFilterPage> createState() => _ProductFilterPageState();
}

final listProduct = [
  Product.getRandomProduct(),
  Product.getRandomProduct(),
  Product.getRandomProduct(),
  Product.getRandomProduct(),
  Product.getRandomProduct(),
  Product.getRandomProduct(),
  Product.getRandomProduct(),
];

class _ProductFilterPageState extends State<ProductFilterPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const FetchListProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    final soldOut = [math.Random().nextBool(), math.Random().nextBool(), math.Random().nextBool(), math.Random().nextBool(), math.Random().nextBool(), math.Random().nextBool(), math.Random().nextBool()];
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: SizedBox(
                height: 40,
                child: SearchBar(
                  surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
                  shadowColor: const MaterialStatePropertyAll(Colors.transparent),
                  elevation: const MaterialStatePropertyAll(0),
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )),
                  backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                  hintText: widget.tagFilter,
                  hintStyle: const MaterialStatePropertyAll(TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  )),
                  leading: const Icon(Icons.search),
                  trailing: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                badges.Badge(
                  badgeContent: BlocBuilder<InQueueListProductCubit<InQueueProduct>, List<InQueueProduct>>(
                    builder: (context, state) {
                      return Text(
                        state.length.toString(),
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
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                )
              ],
            )
          ];
        },
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // if (state is ProductLoaded) {
              // if (state.listProducts!.isEmpty) {
              //   return const Center(
              //     child: Text('No result returning'),
              //   );
              // }
              return AlignedGridView.count(
                shrinkWrap: true,
                itemCount: listProduct.length,
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  final item = listProduct[index];
                  return InkWell(
                    onTap: () {
                      context.read<ProductSelectCubit>().updateProduct(
                            ProductSelect(
                              product: item,
                              select: 0,
                            ),
                          );
                      Get.to(() => const ProductDetailPage());
                    },
                    child: Card(
                      surfaceTintColor: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: 200,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 200,
                                      color: Colors.amberAccent,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          color: Colors.teal,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: const Text(
                                            'XTRA',
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
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
                                    child: StatefulBuilder(
                                      builder: (context, state) {
                                        return IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LineAwesomeIcons.heart_solid,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (soldOut[index])
                                    Positioned.fill(
                                      child: Container(
                                        color: Colors.white24,
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
                              title: Text(
                                '${item.listClassification.first.cost}\$',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.label,
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
                                    maxLines: 3,
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
                            if (index.isEven && index > 0) Container(height: 50),
                            Expanded(
                              child: Container(
                                height: 50,
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.shopping_cart, size: 16),
                                      Text('Shipping Now', style: Theme.of(context).textTheme.titleSmall),
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
              );
            }
            //return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
