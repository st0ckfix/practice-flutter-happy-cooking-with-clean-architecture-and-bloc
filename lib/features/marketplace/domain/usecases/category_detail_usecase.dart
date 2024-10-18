import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/category_detail_repository.dart';

class CategoryDetailUseCase extends UseCase<Either<String, List<CategoryDetailEntity>>, void> {
  CategoryDetailRepository categoryDetailRepository;
  CategoryDetailUseCase(this.categoryDetailRepository);
  @override
  Future<Either<String, List<CategoryDetailEntity>>> call({void params}) {
    return categoryDetailRepository.getCategoryDetail();
  }
}
