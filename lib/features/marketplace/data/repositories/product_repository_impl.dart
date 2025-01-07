import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:happy_cooking/core/datasource/firestore_service.dart';
import 'package:happy_cooking/features/marketplace/data/models/product_model.dart';

import '../../domain/repositories/product_repository.dart';

Map<String, ProductModel>? fullMap;

class ProductRepositoryImpl extends ProductRepository {
  final ReadListFireStore readListFireStore;
  ProductRepositoryImpl({required this.readListFireStore});

  @override
  Future<Either<String, Map<String, ProductModel>>> getProduct() async {
    return await fetchProducts();
  }
}

Future<Either<String, Map<String, ProductModel>>> fetchProducts() async {

  try {
    final String jsonString = await rootBundle.loadString('assets/file/products.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return Right(
      jsonData.map(
        (key, value) => MapEntry(key, ProductModel.fromJson(value)),
      ),
    );
  } catch (e) {
    print(e.toString());
    return Left(e.toString());
  }
}
