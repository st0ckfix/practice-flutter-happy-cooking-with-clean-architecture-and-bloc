import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/product_usecase.dart';

import '../../../domain/entities/product_entity.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductUseCase productUseCase;
  final Map<String?, List<(String, String)>?> listFoodIdsByType = {};
  final Map<String?, List<(String, String)>?> listFoodIdsByTag = {};
  List<(String, String)>? fullListFoodIds;
  List<(String, String)>? fullListTopDeals;
  ProductCubit({required this.productUseCase}) : super(ProductInitial()) {
    fetchData();
  }

  Future<void> fetchData() async {
    emit(const ProductLoading());
    final eitherProduct = await productUseCase.call();
    eitherProduct.fold(
      (error) {
        emit(ProductError(error));
      },
      (data) {
        emit(ProductData(data));
      },
    );
  }

  List<dynamic>? getSublistProduct({
    required List<dynamic>? listProduct,
    int start = 0,
    int? end,
  }) {
    if (listProduct == null) return null;
    final listProductLength = listProduct.length;
    return listProduct.sublist(
        start,
        min(
          end ?? listProductLength,
          listProductLength,
        ));
  }

  List<(String, String)>? setListProductType({required String foodType}) {
    final sortedList = state.mapProducts!.values.where((element) => element.productType == foodType).toList()..sort((a, b) => b.productSold.compareTo(a.productSold));

    final finalList = sortedList.map((e) => (e.productId, e.productLabel)).toList();

    listFoodIdsByType[foodType] = finalList;
    return finalList;
  }

  List<(String, String)>? getListProductByFoodType({required String? foodType, int start = 0, int? end}) {
    if (foodType == null) return null;
    return getSublistProduct(
      listProduct: listFoodIdsByType.containsKey(foodType) ? listFoodIdsByType[foodType] : setListProductType(foodType: foodType),
      start: start,
      end: end,
    ) as List<(String, String)>;
  }

  List<String>? getListProductIdByFoodType({required String? foodType, int start = 0, int? end}) {
    if (foodType == null) return null;
    return getSublistProduct(
      listProduct: getListProductByFoodType(foodType: foodType)?.map((e) => e.$1).toList(),
      start: start,
      end: end,
    ) as List<String>;
  }

  List<(String, String)>? setListProductTag({required String foodTag}) {
    final sortedList = state.mapProducts!.values
        .where(
          (element) => element.productTags.contains(foodTag),
        )
        .toList()
      ..sort(
        (a, b) => b.productSold.compareTo(a.productSold),
      );
    final finalList = sortedList
        .map(
          (e) => (e.productId, e.productLabel),
        )
        .toList();
    listFoodIdsByTag[foodTag] = finalList;
    return finalList;
  }

  List<(String, String)>? getListProductByFoodTag({required String? foodTag, int start = 0, int? end}) {
    if (foodTag == null) return null;
    return getSublistProduct(
      listProduct: listFoodIdsByTag.containsKey(foodTag) ? listFoodIdsByTag[foodTag] : setListProductTag(foodTag: foodTag),
      start: start,
      end: end,
    ) as List<(String, String)>;
  }

  List<String>? getListProductIdByFoodTag({required String? foodTag, int start = 0, int? end}) {
    if (foodTag == null) return null;
    return getSublistProduct(
      listProduct: getListProductByFoodTag(foodTag: foodTag)?.map((e) => e.$1).toList(),
      start: start,
      end: end,
    ) as List<String>;
  }

  List<(String, String)>? setListFoodsId() {
    final sortedList = state.mapProducts!.values.toList()
      ..sort(
        (a, b) => b.productSold.compareTo(a.productSold),
      );
    final finalList = sortedList
        .map(
          (e) => (e.productId, e.productLabel),
        )
        .toList();
    fullListFoodIds = finalList;
    return finalList;
  }

  List<(String, String)>? getListProducts({int start = 0, int? end}) {
    return getSublistProduct(listProduct: fullListFoodIds ?? setListFoodsId(), start: start, end: end) as List<(String, String)>;
  }

  List<String>? getListProductsId({int start = 0, int? end}) {
    return getSublistProduct(listProduct: (fullListFoodIds ?? getListProducts())?.map((e) => e.$1).toList(), start: start, end: end) as List<String>;
  }

  List<(String, String)>? getTopDealsListProductByAll({int start = 0, int? end}) {
    if (fullListTopDeals != null) return fullListTopDeals;
    final sortedList = state.mapProducts!.values.toList()
      ..sort(
        (a, b) => b.productDiscount.compareTo(a.productDiscount),
      );
    final finalList = sortedList
        .map(
          (e) => (e.productId, e.productLabel),
        )
        .toList();
    fullListTopDeals = finalList;
    return getSublistProduct(listProduct: finalList, start: start, end: end) as List<(String, String)>;
  }

  List<String> getTopDealsListProductIdByAll({int start = 0, int? end}) {
    return getSublistProduct(listProduct: getTopDealsListProductByAll()?.map((e) => e.$1).toList(), start: start, end: end) as List<String>;
  }

  bool isAllTopSelling({
    required String foodId,
    int? end,
  }) {
    return getSublistProduct(listProduct: getListProductsId(), start: 0, end: end)!.contains(foodId);
  }

  bool isTypeTopSelling({
    required String foodId,
    required String foodType,
    int? end,
  }) {
    return getSublistProduct(listProduct: getListProductByFoodType(foodType: foodType), start: 0, end: end)!.contains(foodId);
  }

  bool isTagTopSelling({
    required String foodId,
    required String foodTag,
    int? end,
  }) {
    return getSublistProduct(listProduct: getListProductByFoodTag(foodTag: foodTag), start: 0, end: end)!.contains(foodId);
  }

  ProductEntity? getProductByFoodId({required String foodId}) {
    // if (!state.mapProducts!.keys.contains(foodId)) {
    //   print('key: $foodId');
    // }
    return state.mapProducts?[foodId];
  }
}
