import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/category_detail/category_detail_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/bloc/category_detail_item/category_detail_item_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryDetailBloc>().add(const CategoryDetailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                width: constraints.maxWidth * .3,
                child: BlocListener<CategoryDetailBloc, CategoryDetailState>(
                  listener: (context, state) {
                    if (state is CategoryDetailLoaded) {
                      context.read<CategoryDetailItemBloc>().add(CategoryDetailItemEvent(state.listCategoryDetails!.first.id));
                    }
                  },
                  child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
                    builder: (context, state) {
                      if (state is CategoryDetailLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CategoryDetailLoaded) {
                        final list = state.listCategoryDetails!;
                        String valueItem = list.first.id;
                        return StatefulBuilder(builder: (context, stateful) {
                          return ChipsChoice<String>.single(
                            direction: Axis.vertical,
                            value: valueItem,
                            onChanged: (value) {
                              stateful(() {
                                context.read<CategoryDetailItemBloc>().add(CategoryDetailItemEvent(value));
                                valueItem = value;
                              });
                            },
                            choiceCheckmark: true,
                            choiceItems: C2Choice.listFrom<String, CategoryDetailEntity>(
                              source: state.listCategoryDetails!,
                              value: (index, item) => item.id,
                              label: (index, item) => '',
                              avatarImage: (index, item) => AssetImage(item.image),
                              avatarText: (index, item) => Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      item.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    right: 5,
                                    child: Text(
                                      item.label,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              style: (index, item) => const C2ChipStyle(
                                avatarSize: Size(96, 96),
                                overlayColor: Colors.black45,
                                avatarBorderRadius: BorderRadius.all(Radius.circular(8)),
                                height: 100,
                                checkmarkSize: 32.0,
                                checkmarkWeight: 8.0,
                                elevation: 5.0,
                                padding: EdgeInsets.all(2.0),
                                borderColor: Colors.white,
                              ),
                            ),
                          );
                        });
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * .7,
                child: BlocBuilder<CategoryDetailItemBloc, CategoryDetailItemState>(
                  builder: (context, state) {
                    if (state is CategoryDetailItemLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CategoryDetailItemLoaded) {
                      return GridView.builder(
                        itemCount: state.listCategoryDetailItems!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1),
                        itemBuilder: (context, index) {
                          final item = state.listCategoryDetailItems![index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => ProductFilterPage(tagFilter: item.id));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      item.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    right: 5,
                                    child: Text(
                                      item.label,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
