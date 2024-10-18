import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountCubit extends Cubit<CountClass> {
  CountCubit() : super(CountClass(60, false));
  bool resend = false;

  bool get canResendSMS => resend;

  void onChangeResendState(bool resendState) {
    resend = resendState;
  }

  Future<void> decreaseCount() async {
    int count = state.value - 1;
    emit(state.copywith(value: () => count));
  }

  Future<void> resetCubit() async {
    emit(state.defaultClass());
  }

  Future<void> runCubit() async {
    if (state.isRunning) return;
    emit(state.copywith(isRunning: () => true));
  }

  Future<void> pauseCubit() async {
    if (!state.isRunning) return;
    emit(state.copywith(isRunning: () => false));
  }
}

class CountClass {
  int value;
  bool isRunning;

  CountClass(this.value, this.isRunning);

  CountClass defaultClass() {
    return CountClass(60, false);
  }

  CountClass copywith({
    ValueGetter<int>? value,
    ValueGetter<bool>? isRunning,
  }) {
    return CountClass(value != null ? value() : this.value, isRunning != null ? isRunning() : this.isRunning);
  }
}
