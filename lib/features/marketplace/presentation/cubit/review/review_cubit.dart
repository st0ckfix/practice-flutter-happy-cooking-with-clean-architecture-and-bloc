import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/review_entity.dart';
import '../../../domain/usecases/review_usecase.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewUseCase reviewUseCase;
  final Map<String, List<ReviewEntity>> mapReviews = {};
  ReviewCubit({required this.reviewUseCase}) : super(const ReviewInitial());

  Future<void> fetchListReviewsByProductId(String productId) async {
    emit(const ReviewLoading());
    if (mapReviews.containsKey(productId)) {
      emit(ReviewData(mapReviews[productId]!));
    } else {
      await reviewUseCase.call(params: productId).then(
        (value) {
          value.fold(
            (error) {
              emit(ReviewError(error));
            },
            (listReviews) {
              mapReviews[productId] = listReviews
                ..sort((a, b) => b.reviewValue.compareTo(a.reviewValue))
                ..sort((a, b) => (b.reviewContent?.length ?? 0).compareTo(a.reviewContent?.length ?? 0));
              emit(ReviewData(listReviews));
            },
          );
        },
      );
    }
  }
}
