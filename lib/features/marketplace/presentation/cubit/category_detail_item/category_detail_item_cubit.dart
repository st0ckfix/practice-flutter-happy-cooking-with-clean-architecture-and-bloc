import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_item_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_item_usecase.dart';

part 'category_detail_item_state.dart';

class CategoryDetailItemCubit extends Cubit<CategoryDetailItemState> {
  CategoryDetailItemUseCase categoryDetailItemUseCase;
  CategoryDetailItemCubit({required this.categoryDetailItemUseCase}) : super(CategoryDetailItemInitial()) {
    fetchData('beef');
  }

  Future<void> fetchData(String category) async {
    emit(const CategoryDetailItemLoading());
    final data = await categoryDetailItemUseCase(params: category);
    data.fold(
      (error) {
        emit(CategoryDetailItemError(error));
      },
      (data) {
        emit(CategoryDetailItemLoaded(data));
      },
    );
  }

}
