import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/product_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_detail_page.dart';
import 'package:happy_cooking/features/marketplace/presentation/pages/product_filter_page.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List<(String, String)> suggestionInitial;
  List<(String, String)>? suggestionList;
  CustomSearchDelegate({String initialQuery = '', required this.suggestionInitial}) {
    query = initialQuery;
  }

  // Hàm hiển thị gợi ý tìm kiếm
  @override
  Widget buildSuggestions(BuildContext context) {
    suggestionList = query.isEmpty
        ? suggestionInitial
        : suggestionInitial
            .where(
              (item) => item.$2.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    return ListView.separated(
      itemCount: suggestionList!.sublist(0, min(10, suggestionList!.length)).length,
      itemBuilder: (context, index) {
        final listText = suggestionList![index].$2.toLowerCase().split(query.toLowerCase());
        final finalList = <String>[];
        
        for (final text in listText) {
          finalList.add(text);
          if (text != listText.last) {
            finalList.add(query.toLowerCase());
          }
        }

        return InkWell(
          onTap: () {
            context.read<ProductSelectCubit>().updateProduct(suggestionList![index].$1);
            Get.off(
              () => const ProductDetailPage(),
              duration: const Duration(milliseconds: 1500),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text.rich(
              TextSpan(
                children: finalList
                    .map((e) => TextSpan(
                          text: e.toLowerCase(),
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: e == query ? FontWeight.bold : FontWeight.normal,
                              ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(height: 5, thickness: 1),
        );
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    Get.off(
      () => ProductFilterPage(
        title: query,
        foodIds: suggestionList,
      ),
      duration: const Duration(milliseconds: 1500),
    );
  }

  // Hàm hiển thị giao diện tìm kiếm
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Xóa văn bản tìm kiếm
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }
}
