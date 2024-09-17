import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/labels/otp_label.dart';
import 'package:happy_cooking/core/constants/tag.dart';
import '../../cubit/count_cubit.dart';
import '../../pages/vertify_page.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({super.key, required this.resendSMS});

  final Function resendSMS;

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  @override
  void dispose() {
    super.dispose();
    countCubit.resetCubit();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        countCubit.resetCubit();
      },
      child: BlocListener<CountCubit, CountClass>(
        listener: (context, state) {
          if (countCubit.state.value == 0) {
            countCubit.pauseCubit();
          }
          if (countCubit.state.isRunning) {
            Future.delayed(const Duration(seconds: 1)).then((value) {
              countCubit.decreaseCount();
            });
          }
        },
        child: BlocBuilder<CountCubit, CountClass>(
          bloc: countCubit,
          builder: (_, state) {
            return Column(
              children: [
                if (state.value == 0 && countCubit.canResendSMS)
                  CustomButton(
                    key: const Key(resendTag),
                    isOutlined: false,
                    icon: const SizedBox.shrink(),
                    label: resendLabel.toUpperCase(),
                    onClick: () {
                      countCubit.resetCubit().then((value) {
                        widget.resendSMS();
                      });
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(state.value == 0 ? otpResendDoneLabel : '$otpResendWaitLabel${countCubit.state.value} s')
              ],
            );
          },
        ),
      ),
    );
  }
}
