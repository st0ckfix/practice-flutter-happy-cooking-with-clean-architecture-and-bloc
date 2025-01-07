part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  final List<ReviewEntity>? listReviews;
  final String? error;
  const ReviewState({this.listReviews, this.error});

  @override
  List<Object> get props => [listReviews!, error!];
}

final class ReviewInitial extends ReviewState {
  const ReviewInitial() : super();
}

final class ReviewLoading extends ReviewState {
  const ReviewLoading() : super();
}

final class ReviewData extends ReviewState {
  const ReviewData(List<ReviewEntity> listReviews) : super(listReviews: listReviews);
}

final class ReviewError extends ReviewState {
  const ReviewError(String error) : super(error: error);
}
