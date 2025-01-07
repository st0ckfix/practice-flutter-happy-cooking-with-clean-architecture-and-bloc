import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/main.dart';

class TokenDiscountCubit extends Cubit<int> {
  TokenDiscountCubit() : super(0) {
    logg('Token Discount', 'init', 'value: $state');
  }
  void updateToken(int newToken) {
    logg('Token Discount', 'update', 'value: $newToken');
    emit(newToken);
  }
}
