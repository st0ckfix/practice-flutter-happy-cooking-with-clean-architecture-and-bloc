import 'package:flutter_bloc/flutter_bloc.dart';

class TokenDiscountCubit extends Cubit<int> {
  TokenDiscountCubit() : super(0);

  void updateDiscountToken(int tokens) {
    emit(tokens);
  }
}
