import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/vertify_routes.dart';
import 'package:happy_cooking/core/utils/extention.dart';
import 'package:happy_cooking/features/vertify/presentation/bloc/vertify_email/vertify_email_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/theme/color.dart';
import '../widgets/vertify/vertify_email_widget.dart';
import '../widgets/vertify/vertify_phone_widget.dart';

enum VertifyForm { email, phone, reset }

class VertifyScreen extends StatefulWidget {
  const VertifyScreen({
    super.key,
    required this.form,
    this.email,
    this.callbackEmail,
    this.callbackPhone,
    required this.fieldValidator,
  });

  final VertifyForm form;
  final String? email;
  final Function(String)? callbackEmail;
  final Function(PhoneAuthCredential)? callbackPhone;
  final String? Function(String?) fieldValidator;

  @override
  State<VertifyScreen> createState() => _VertifyScreenState();
}

class _VertifyScreenState extends State<VertifyScreen> {
  late Brightness brightness;
  late bool isDarkmode;
  late String agrument;
  bool isCurrent = true;
  final fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkmode = brightness == Brightness.dark;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.email.let((it) {
        agrument = it;
        fieldController.setText(it);
        context.read<VertifyEmailBloc>().add(VertifyEmailEvent(it));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkmode ? secondaryColor : Colors.white,
      body: _buildBody(isDarkmode),
    );
  }

  _buildBody(bool isDarkmode) {
    log('VerifyScreen/_buildBody');
    return {
      VertifyForm.email: VertifyEmailWidget(
        fieldController: fieldController,
        callbackEmail: (email) => agrument = email,
        callbackCode: (code) => navigateSMS(code),
      ),
      VertifyForm.phone: VertifyPhoneWidget(
        fieldController: fieldController,
        callbackPhone: (phone) => agrument = phone,
        callback: () => navigateSMS(null),
      ),
    }[widget.form];
  }

  void navigateSMS(String? emailCode) => Get.toNamed(VertifyRoutes.smsVertify, arguments: {
        'agrument': agrument,
        'emailCode': emailCode,
        'callbackEmail': widget.callbackEmail != null ? () => widget.callbackEmail!(agrument) : null,
        'callbackPhone': widget.callbackPhone != null ? (PhoneAuthCredential phoneAuthentication) => widget.callbackPhone!(phoneAuthentication) : null,
      });
}
