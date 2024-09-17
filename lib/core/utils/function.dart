import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resource/data_state.dart';

void onToast(String message, Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Fluttertoast.showToast(msg: message).then((value) => callback());
  });
}

Future<DataState> onStateProgress(Future function) async {
  try {
    final state = await function;
    if (state is String) {
      return DataFailed(state);
    } else if (state is Object) {
      return DataException(DioException(requestOptions: RequestOptions()));
    } else {
      return DataSuccess(state);
    }
  } on DioException catch (exception) {
    return DataException(exception);
  }
}
