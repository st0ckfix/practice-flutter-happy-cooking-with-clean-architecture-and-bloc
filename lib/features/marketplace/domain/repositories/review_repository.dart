import 'package:dartz/dartz.dart';

import '../entities/review_entity.dart';

abstract class ReviewRepository<T> {
  Future<Either<String, List<ReviewEntity>>> getReviews(String productId);
}
