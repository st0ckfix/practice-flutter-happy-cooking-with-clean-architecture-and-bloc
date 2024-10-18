import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/product_repository.dart';

import '../entities/product_entity.dart';

class ProductUseCase extends UseCase<Either<String, List<ProductEntity>>, String> {
  final ProductRepository productRepository;
  ProductUseCase(this.productRepository);
  @override
  Future<Either<String, List<ProductEntity>>> call({String? params}) {
    return productRepository.getProduct(params!);
  }
}
