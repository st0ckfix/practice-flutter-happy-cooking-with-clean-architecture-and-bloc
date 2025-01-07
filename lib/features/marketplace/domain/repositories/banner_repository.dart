import 'package:dartz/dartz.dart';

import '../entities/banner_entity.dart';


abstract class BannerRepository<T> {
  Future<Either<String, Map<String, BannerEntity>>> getBanner();
}
