import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_usecase.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';

class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  final CategoryDetailUseCase categoryDetailUseCase;
  CategoryDetailBloc(this.categoryDetailUseCase) : super(const CategoryDetailInitial()) {
    on<CategoryDetailEvent>((event, emit) async {
      emit(const CategoryDetailLoading());
      final data = await categoryDetailUseCase();
      data.fold(
        (error) {
          emit(CategoryDetailError(error));
        },
        (data) {
          emit(CategoryDetailLoaded(data));
        },
      );
    });
  }
}
