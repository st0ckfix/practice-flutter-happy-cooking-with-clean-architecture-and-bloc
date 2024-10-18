
import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/otp_text_field.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/resend_code.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/vertify_label.dart';

class SMSVertifyWidget extends StatelessWidget {
  const SMSVertifyWidget({
    super.key,
    required this.agrument,
    required this.isDarkmode,
    required this.onPinSubmit,
    required this.onResend,
    required this.textEditingController,
  });

  final String agrument;
  final bool isDarkmode;
  final TextEditingController textEditingController;
  final Function(String) onPinSubmit;
  final Function onResend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VertifyLabelWidget(
                agrument: agrument,
              ),
              OtpTextfieldWidget(
                textEditingController: textEditingController,
                isDarkmode: isDarkmode,
                onSubmit: (pin) => onPinSubmit(pin),
              ),
              ResendCodeWidget(
                resendSMS: () => onResend(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
