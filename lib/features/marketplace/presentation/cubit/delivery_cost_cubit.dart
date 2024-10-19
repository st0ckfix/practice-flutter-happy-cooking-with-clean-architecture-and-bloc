import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryCostCubit extends Cubit<DeliveryOption> {
  DeliveryCostCubit() : super(DeliveryOption.today());

  void updateDelivery(DeliveryOption deliveryOption) {
    emit(deliveryOption);
  }
}

class DeliveryOption {
  final String label;
  final String message;
  final double cost;

  DeliveryOption({required this.label, required this.message, required this.cost});

  factory DeliveryOption.today() => DeliveryOption(label: 'Delivery Today', message: 'Delivery: Today, before 18:00', cost: 3.5);

  factory DeliveryOption.later() => DeliveryOption(label: 'Delivery Later', message: 'Delivery: Later, before 2 days later', cost: 1.5);
}
