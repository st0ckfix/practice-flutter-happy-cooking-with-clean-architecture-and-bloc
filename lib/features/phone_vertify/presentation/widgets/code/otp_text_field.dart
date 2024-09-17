import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:pinput/pinput.dart';

class OtpTextfieldWidget extends StatefulWidget {
  const OtpTextfieldWidget({
    super.key,
    required this.isDarkmode,
    required this.onSubmit,
    required this.textEditingController,
  });

  final bool isDarkmode;
  final Function(String) onSubmit;
  final TextEditingController textEditingController;

  @override
  State<OtpTextfieldWidget> createState() => _OtpTextfieldState();
}

class _OtpTextfieldState extends State<OtpTextfieldWidget> {
  

  late PinTheme defaultPinTheme;
  late PinTheme focusPinTheme;
  late PinTheme errorPinTheme;

  @override
  void initState() {
    super.initState();

    defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 24, color: widget.isDarkmode ? Colors.white : const Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w900),
      decoration: BoxDecoration(
        border: Border.all(color: widget.isDarkmode ? Colors.white38 : const Color.fromRGBO(30, 60, 87, 1).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    focusPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: widget.isDarkmode ? Colors.white : const Color.fromRGBO(30, 60, 87, 1)),
    );

    errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      child: Pinput(
        controller: widget.textEditingController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusPinTheme,
        errorPinTheme: errorPinTheme,
        length: 6,
        validator: (validator) {
          return widget.textEditingController.text.isEmpty || widget.textEditingController.text.length < 6 ? 'Pincode invalid' : null;
        },
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) {
          widget.onSubmit(pin);
          widget.textEditingController.clear();
        },
      ),
    );
  }
}
