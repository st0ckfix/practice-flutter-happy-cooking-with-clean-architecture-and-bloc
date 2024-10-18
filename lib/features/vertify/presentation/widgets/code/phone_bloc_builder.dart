import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/vertify/presentation/pages/vertify_page.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/s_m_s_vertify_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../bloc/vertify_phone/vertify_phone_bloc.dart';

class PhoneBlocBuilder extends StatelessWidget {
  const PhoneBlocBuilder({
    super.key,
    required this.agrument,
    required this.isDarkmode,
    required this.textEditingController,
    required this.callbackVertifyPhone,
  });

  final String agrument;
  final bool isDarkmode;
  final TextEditingController textEditingController;
  final Function(PhoneAuthCredential) callbackVertifyPhone;

  @override
  Widget build(BuildContext context) {
    String verificationId = '';
    return MultiBlocListener(
      listeners: [
        BlocListener<VertifyPhoneBloc, VertifyPhoneState>(
          listener: (context, state) {
            if (ModalRoute.of(context)?.isCurrent ?? false) {
              if (state is VertifyPhoneLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
                if (state is VertifyPhoneCodeSent) {
                  log('SMS Code has been sent');
                  verificationId = state.dateIfNeded!;
                }
                if (state is VertifyPhoneRequestAccepted) {
                  log('SMS Code Request has been accepted');
                  countCubit.onChangeResendState(false);
                  countCubit.runCubit();
                }
                if (state is VertifyPhoneTimeout) {
                  log('Verification has timed out');
                  countCubit.onChangeResendState(true);
                }
                if (state is VertifyPhoneAutoVerification) {
                  log('SMS code has been auto-filled');
                  textEditingController.text = state.phoneAuthCredential!.smsCode!;
                }
              }
            }
          },
        ),
      ],
      child: Stack(
        children: [
          SMSVertifyWidget(
            agrument: agrument,
            isDarkmode: isDarkmode,
            textEditingController: textEditingController,
            onPinSubmit: (pin) {
              callbackVertifyPhone(
                PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: pin,
                ),
              );
            },
            onResend: () {
              countCubit.pauseCubit();
              context.read<VertifyPhoneBloc>().add(VertifyPhoneEvent(agrument));
            },
          ),
        ],
      ),
    );
  }
}
