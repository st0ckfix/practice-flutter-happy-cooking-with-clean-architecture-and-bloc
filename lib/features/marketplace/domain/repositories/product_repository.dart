import 'package:dartz/dartz.dart';

import '../entities/product_entity.dart';

abstract class ProductRepository<T> {
  Future<Either<String, Map<String, ProductEntity>>> getProduct();
}
