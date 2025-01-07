part of 'in_queue_bloc.dart';

class SelectSingle extends CartEvent {
  final String cartId;
  const SelectSingle({required this.cartId});
}

class SelectAll extends CartEvent {
  const SelectAll();
}

class UnselectSingle extends CartEvent {
  final String cartId;
  const UnselectSingle({required this.cartId});
}

class UnselectAll extends CartEvent {
  const UnselectAll();
}
