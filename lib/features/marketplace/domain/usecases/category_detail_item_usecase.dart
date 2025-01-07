import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_item_repository.dart';

import '../entities/category_detail_item_entity.dart';

class CategoryDetailItemUseCase<T> extends UseCase<Either<String, List<CategoryDetailItemEntity>>, String> {
  final CategoryDetailItemRepository categoryDetailItemRepository;
  CategoryDetailItemUseCase({required this.categoryDetailItemRepository});

  @override
  Future<Either<String, List<CategoryDetailItemEntity>>> call({String? params}) {
    return categoryDetailItemRepository.getCategoryDetailItem(params);
  }
}
