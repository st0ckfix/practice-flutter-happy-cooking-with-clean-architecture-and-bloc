import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../../core/datasource/firestore_service.dart';
import '../../domain/repositories/review_repository.dart';
import '../models/review_model.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final ReadListFireStore readListFireStore;
  ReviewRepositoryImpl({required this.readListFireStore});

  @override
  Future<Either<String, List<ReviewModel>>> getReviews(String productId) async {
    return fetchReviews(productId);
  }
}

Future<Either<String, List<ReviewModel>>> fetchReviews(String productId) async {
  try {
    final String jsonString = await rootBundle.loadString('assets/file/reviews.json');
    log(productId);
    final data = (jsonDecode(jsonString) as Map<String, dynamic>)[productId] as List;
    return Right(data.map((e) => ReviewModel.fromJson(e)).toList());
  } catch (e) {
    print(e.toString());
    return Left(e.toString());
  }
}
