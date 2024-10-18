part of 'category_detail_item_bloc.dart';

abstract class CategoryDetailItemState extends Equatable {
  final List<CategoryDetailItemEntity>? listCategoryDetailItems;
  final String? error;
  const CategoryDetailItemState({this.listCategoryDetailItems, this.error});

  @override
  List<Object> get props => [listCategoryDetailItems!, error!];
}

final class CategoryDetailItemInitial extends CategoryDetailItemState {
  const CategoryDetailItemInitial();
}

final class CategoryDetailItemLoading extends CategoryDetailItemState {
  const CategoryDetailItemLoading();
}

final class CategoryDetailItemLoaded extends CategoryDetailItemState {
  const CategoryDetailItemLoaded(List<CategoryDetailItemEntity> listCategoryDetailItems) : super(listCategoryDetailItems: listCategoryDetailItems);
}

final class CategoryDetailItemError extends CategoryDetailItemState {
  const CategoryDetailItemError(String error) : super(error: error);
}