import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/banner_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/repositories/banner_repository.dart';

import '../../../../core/usecases/usecase.dart';

class BannerUseCase extends UseCase<Either<String, Map<String, BannerEntity>>, void> {
  final BannerRepository bannerRepository;
  BannerUseCase({required this.bannerRepository});

  @override
  Future<Either<String, Map<String, BannerEntity>>> call({void params}) {
    return bannerRepository.getBanner();
  }
}
