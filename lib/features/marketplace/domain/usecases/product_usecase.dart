import 'package:dartz/dartz.dart';
import 'package:happy_cooking/core/usecases/usecase.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/product_repository.dart';

import '../entities/product_entity.dart';


class ProductUseCase extends UseCase<Either<String, Map<String, ProductEntity>>, String> {
  final ProductRepository productRepository;
  ProductUseCase({required this.productRepository});
  @override
  Future<Either<String, Map<String, ProductEntity>>> call({void params}) {
    return productRepository.getProduct();
  }
}
