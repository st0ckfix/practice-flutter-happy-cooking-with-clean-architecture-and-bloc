part of 'category_detail_cubit.dart';

abstract class CategoryDetailState extends Equatable {
  final List<CategoryDetailEntity>? listCategoryDetails;
  final String? error;
  const CategoryDetailState({this.listCategoryDetails, this.error});

  @override
  List<Object> get props => [listCategoryDetails!, error!];
}

final class CategoryDetailInitial extends CategoryDetailState {
   CategoryDetailInitial() : super(listCategoryDetails: []);
}

final class CategoryDetailLoading extends CategoryDetailState {
  const CategoryDetailLoading();
}

final class CategoryDetailLoaded extends CategoryDetailState {
  const CategoryDetailLoaded(List<CategoryDetailEntity> listCategoryDetails) : super(listCategoryDetails: listCategoryDetails);
}

final class CategoryDetailError extends CategoryDetailState {
  const CategoryDetailError(String error) : super(error: error);
}
