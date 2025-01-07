import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<Payment> {
  PaymentCubit() : super(Payment.cashOnDelivery());

  void updatePayment(Payment payment) {
    if (state == payment) return;
    emit(payment);
  }
}

class Payment {
  final String label;
  final String icon;

  const Payment({
    required this.label,
    required this.icon,
  });

  factory Payment.cashOnDelivery() {
    return const Payment(
      label: 'Cash on Delivery',
      icon: 'assets/images/cash.png',
    );
  }

  factory Payment.mastercard() {
    return const Payment(
      label: 'Debit Card',
      icon: 'assets/images/mastercard.png',
    );
  }

  factory Payment.paypal() {
    return const Payment(
      label: 'Paypal',
      icon: 'assets/images/paypal.png',
    );
  }
}
