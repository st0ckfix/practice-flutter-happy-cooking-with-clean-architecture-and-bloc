import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/payment_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/select_list_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const TitleWidget('Payment'),
                const Spacer(),
                InkWellTextWidget(
                  'Change',
                  onClick: () => Get.to(
                    () => const PaymentOptionFragment(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            alignment: Alignment.center,
            child: BlocBuilder<PaymentCubit, Payment>(
              builder: (context, payment) {
                return Row(
                  children: [
                    Image.asset(payment.icon, height: 24, width: 24),
                    const SizedBox(width: 10),
                    Text(payment.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentOptionFragment extends StatelessWidget {
  const PaymentOptionFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final listPayments = [
      Payment.cashOnDelivery(),
      Payment.mastercard(),
      Payment.paypal(),
    ];
    int currentSelect = listPayments.indexWhere((element) => element.label == context.read<PaymentCubit>().state.label);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        title: const Text('Payment Options'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: SelectListWidget(
              layoutBuilder: (_, index, isSelected) {
                final payment = listPayments[index];
                return Row(
                  children: [
                    const SizedBox(width: 10),
                    Image.asset(payment.icon, height: 24, width: 24),
                    const SizedBox(width: 10),
                    Text(
                      payment.label,
                      style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    ),
                  ],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 9 / 2,
              ),
              itemCount: 3,
              onSelect: (select, {selectList}) => currentSelect = select,
              selectMode: SelectMode.single,
              margin: const EdgeInsets.all(10),
              addOnCheck: AddOnCheck.trailingRadio,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 5),
                isOutlined: false,
                title: 'Select',
                fontSize: 15,
                onClick: () => {context.read<PaymentCubit>().updatePayment(listPayments[currentSelect]), Get.back()},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
