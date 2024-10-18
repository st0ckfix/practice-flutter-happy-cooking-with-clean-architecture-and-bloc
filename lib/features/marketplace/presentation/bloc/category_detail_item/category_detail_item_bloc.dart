import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_item_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_item_usecase.dart';

part 'category_detail_item_event.dart';
part 'category_detail_item_state.dart';

class CategoryDetailItemBloc extends Bloc<CategoryDetailItemEvent, CategoryDetailItemState> {
  CategoryDetailItemUseCase categoryDetailItemUseCase;
  CategoryDetailItemBloc(this.categoryDetailItemUseCase) : super(const CategoryDetailItemInitial()) {
    on<CategoryDetailItemEvent>((event, emit) async {
      emit(const CategoryDetailItemLoading());
      final data = await categoryDetailItemUseCase(params: event.id);
      data.fold(
        (error) {
          emit(CategoryDetailItemError(error));
        },
        (data) {
          emit(CategoryDetailItemLoaded(data));
        },
      );
    });
  }
}
