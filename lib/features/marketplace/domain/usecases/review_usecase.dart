import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/review_entity.dart';
import '../repositories/review_repository.dart';

class ReviewUseCase extends UseCase<Either<String, List<ReviewEntity>>, String> {
  final ReviewRepository recipeRepository;
  ReviewUseCase({required this.recipeRepository});

  @override
  Future<Either<String, List<ReviewEntity>>> call({String? params}) {
    return recipeRepository.getReviews(params!);
  }
}
