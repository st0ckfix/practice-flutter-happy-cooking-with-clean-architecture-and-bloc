part of 'category_detail_item_bloc.dart';

final class CategoryDetailItemEvent extends Equatable {
  final String id;
  const CategoryDetailItemEvent(this.id);

  @override
  List<Object> get props => [id];
}
