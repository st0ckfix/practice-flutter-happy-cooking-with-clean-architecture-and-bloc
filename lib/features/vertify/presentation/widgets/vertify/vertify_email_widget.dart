import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/labels/vertify_label.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/vertify/presentation/pages/vertify_page.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/vertify/vertify_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../bloc/vertify_email/vertify_email_bloc.dart';

class VertifyEmailWidget extends StatelessWidget {
  const VertifyEmailWidget({
    super.key,
    required this.fieldController,
    required this.callbackEmail,
    required this.callbackCode,
  });
  final TextEditingController fieldController;
  final Function(String email) callbackEmail;
  final Function(String code) callbackCode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VertifyEmailBloc, VertifyEmailState>(
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          if (state is VertifyEmailSuccessful) {
            callbackCode(state.dataIfNeeded!);
          }
          if (state is VertifyEmailLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        }
      },
      child: BlocBuilder<VertifyEmailBloc, VertifyEmailState>(
        builder: (context, state) {
          return Stack(
            children: [
              VertifyWidget(
                callback: (email) {
                  callbackEmail(email);
                  if (state is VertifyEmailInitial || countCubit.canResendSMS) {
                    context.read<VertifyEmailBloc>().add(VertifyEmailEvent(email));
                  } else {
                    onToast('Too many request, please wait until //${countCubit.state.value} s', () {});
                  }
                },
                fieldController: fieldController,
                firstLabel: emailViaLabel,
                secondLabel: emailViaSubLabel,
                thirdLabel: emailLabel,
              ),
            ],
          );
        },
      ),
    );
  }
}
