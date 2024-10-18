import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/vertify/presentation/pages/vertify_page.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/code/s_m_s_vertify_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../bloc/vertify_email/vertify_email_bloc.dart';

class EmailBlocBuilder extends StatelessWidget {
  const EmailBlocBuilder({
    super.key,
    required this.agrument,
    required this.isDarkmode,
    required this.textEditingController,
    required this.callback,
    this.code,
  });
  final String? code;
  final String agrument;
  final bool isDarkmode;
  final TextEditingController textEditingController;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    String? emailCode = code;
    return BlocListener<VertifyEmailBloc, VertifyEmailState>(
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          if (state is VertifyEmailLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
            if (state is VertifyEmailSuccessful) {
              countCubit.onChangeResendState(false);
              countCubit.runCubit();
              emailCode = state.dataIfNeeded;
            }
            if (state is VertifyEmailFailed) {
              countCubit.resetCubit();
              emailCode = null;
              onToast(state.failedReason!, () {});
            }
          }
        }
      },
      child: BlocBuilder<VertifyEmailBloc, VertifyEmailState>(
        builder: (context, state) {
          return Stack(
            children: [
              SMSVertifyWidget(
                agrument: agrument,
                isDarkmode: isDarkmode,
                textEditingController: textEditingController,
                onPinSubmit: (pin) {
                  if (emailCode! == pin) callback();
                },
                onResend: () {
                  countCubit.pauseCubit();
                  context.read<VertifyEmailBloc>().add(VertifyEmailEvent(agrument));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
