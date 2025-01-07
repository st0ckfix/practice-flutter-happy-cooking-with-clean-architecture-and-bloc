import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_item_entity.dart';

abstract class CategoryDetailItemRepository<T> {
  Future<Either<String, List<CategoryDetailItemEntity>>> getCategoryDetailItem(String? category);
}
