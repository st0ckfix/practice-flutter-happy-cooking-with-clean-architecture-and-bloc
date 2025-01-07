import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/category_detail/category_detail_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/category_detail_item/category_detail_item_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/select_list_widget.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                width: constraints.maxWidth * .3,
                child: BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
                  builder: (context, state) {
                    if (state is CategoryDetailLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CategoryDetailLoaded) {
                      final list = state.listCategoryDetails;
                      if (list!.isEmpty) {
                        return const Center(
                          child: Text('Empty Data'),
                        );
                      }

                      return SelectListWidget(
                        onSelect: (pos, {selectList}) {
                          context.read<CategoryDetailItemCubit>().fetchData(list[pos].id);
                        },
                        layoutBuilder: (context, index, _) {
                          final item = list[index];
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: Hero(
                                  tag: item.id,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.asset(
                                          item.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const Positioned.fill(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], stops: [.4, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                                        ),
                                      ),
                                    ],
                                  ),
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
                          );
                        },
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: list.length,
                        selectMode: SelectMode.single,
                        itemInit: const [0],
                        axis: Axis.vertical,
                        padding: const EdgeInsets.all(2),
                        addOnCheck: AddOnCheck.empty,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * .7,
                child: BlocBuilder<CategoryDetailItemCubit, CategoryDetailItemState>(
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
                              Get.to(
                                () => ProductFilterPage(
                                  title: item.label,
                                  foodType: item.id,
                                ),
                              );
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
                                      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], stops: [.4, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
