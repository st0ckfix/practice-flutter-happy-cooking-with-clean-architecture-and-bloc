import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/profile_routes.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/constants/labels/success_label.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/phone_vertify/phone_vertify_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/sms_vertify/sms_vertify_bloc.dart';

import '../../../../shared-widget/loading_dialog.dart';
import '../widgets/code/otp_text_field.dart';
import '../widgets/code/resend_code.dart';
import '../widgets/code/vertify_label.dart';
import 'vertify_page.dart';

class PhoneVertifySMSCodeScreen extends StatefulWidget {
  const PhoneVertifySMSCodeScreen({
    super.key,
    required this.agrument,
    required this.resendSMS,
  });

  final String agrument;
  final Function resendSMS;

  @override
  State<PhoneVertifySMSCodeScreen> createState() => _PhoneVertifySMSCodeState();
}

class _PhoneVertifySMSCodeState extends State<PhoneVertifySMSCodeScreen> {
  late TextEditingController textEditingController;
  late Brightness brightness;
  late bool isDarkmode;
  late String verificationId;

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
    return PopScope(
      onPopInvoked: (didPop) {
        countCubit.resetCubit().then((value) => countCubit.pauseCubit());
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<PhoneVertifySMSCodeBloc, PhoneVertifySMSCodeState>(
              listener: (context, state) {
                if (state is PhoneVertifySMSCodeSuccessful) {
                  onToast(successLoginLabel, () {
                    Get.offAllNamed(ProfileRoutes.profile);
                  });
                }
                if (state is PhoneVertifySMSCodeFailed) {
                  onToast(state.failedReason!, () {});
                }
              },
            ),
            BlocListener<PhoneVertifyBloc, PhoneVertifyState>(
              listener: (context, state) {
                if (state is PhoneVertifySMSSent) {
                  log('SMS Code has been sent');
                  verificationId = state.dateIfNeded!;
                }
                if (state is PhoneVertifyRequestDone) {
                  log('SMS Code Request has been accepted');
                  countCubit.onChangeResendState(false);
                  countCubit.runCubit();
                }
                if (state is PhoneVertifyTimeout) {
                  log('Verification has timed out');
                  countCubit.onChangeResendState(true);
                }
                if (state is PhoneVertifySMSAutoComplete) {
                  log('SMS code has been auto-filled');
                  textEditingController.text = state.phoneAuthCredential!.smsCode!;
                }
              },
            ),
          ],
          child: BlocBuilder<PhoneVertifySMSCodeBloc, PhoneVertifySMSCodeState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(defaultSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VertifyLabelWidget(
                            agrument: widget.agrument,
                          ),
                          OtpTextfieldWidget(
                            textEditingController: textEditingController,
                            isDarkmode: isDarkmode,
                            onSubmit: (pin) {
                              log('Pinput has been submitted');
                              context.read<PhoneVertifySMSCodeBloc>().add(
                                    PhoneVertifySMSCodeEvent(
                                      smsCode: pin,
                                      verificationId: verificationId,
                                    ),
                                  );
                            },
                          ),
                          ResendCodeWidget(
                            resendSMS: () {
                              countCubit.pauseCubit();
                              widget.resendSMS();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is PhoneVertifySMSCodeLoading) const LoadingIndicator()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
