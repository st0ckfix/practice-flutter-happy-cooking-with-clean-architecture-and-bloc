import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/email_bloc_builder.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/phone_bloc_builder.dart';

class PhoneVertifySMSCodeScreen extends StatefulWidget {
  const PhoneVertifySMSCodeScreen({
    super.key,
    this.emailCode,
    required this.agrument,
    this.callbackEmail,
    this.callbackPhone,
  });

  final String? emailCode;
  final String agrument;
  final Function? callbackEmail;
  final Function(PhoneAuthCredential)? callbackPhone;
  @override
  State<PhoneVertifySMSCodeScreen> createState() => _PhoneVertifySMSCodeState();
}

class _PhoneVertifySMSCodeState extends State<PhoneVertifySMSCodeScreen> {
  late TextEditingController textEditingController;
  late Brightness brightness;
  late bool isDarkmode;

  @override
  void initState() {
    super.initState();
    brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkmode = brightness == Brightness.dark;
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.emailCode == null
          ? PhoneBlocBuilder(
              agrument: widget.agrument,
              isDarkmode: isDarkmode,
              textEditingController: textEditingController,
              callbackVertifyPhone: (phoneAuthCredential) => widget.callbackPhone!(phoneAuthCredential),
            )
          : EmailBlocBuilder(
              code: widget.emailCode,
              agrument: widget.agrument,
              isDarkmode: isDarkmode,
              textEditingController: textEditingController,
              callback: () => widget.callbackEmail!(),
            ),
    );
  }
}
