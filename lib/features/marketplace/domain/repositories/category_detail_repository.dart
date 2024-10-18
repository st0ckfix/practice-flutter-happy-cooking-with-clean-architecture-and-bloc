import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';

abstract class CategoryDetailRepository<T> {
  Future<Either<String, List<CategoryDetailEntity>>> getCategoryDetail();
}
