import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/category_detail_entity.dart';
import 'package:happy_cooking/features/marketplace/domain/usecases/category_detail_usecase.dart';

part 'category_detail_state.dart';

class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  final CategoryDetailUseCase categoryDetailUseCase;
  CategoryDetailCubit({required this.categoryDetailUseCase}) : super(CategoryDetailInitial()) {
    fetchData();
  }

  Future<void> fetchData() async {
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
  }
}
