import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/labels/vertify_label.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/vertify/presentation/bloc/vertify_phone/vertify_phone_bloc.dart';
import 'package:happy_cooking/features/vertify/presentation/pages/vertify_page.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/vertify/vertify_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VertifyPhoneWidget extends StatelessWidget {
  const VertifyPhoneWidget({
    super.key,
    required this.fieldController,
    required this.callbackPhone,
    required this.callback,
  });
  final TextEditingController fieldController;
  final Function(String phoneNumber) callbackPhone;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VertifyPhoneBloc, VertifyPhoneState>(
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          if (state is VertifyPhoneLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
            if (state is VertifyPhoneRequestAccepted) {
              callback();
            }
          }
        }
      },
      child: BlocBuilder<VertifyPhoneBloc, VertifyPhoneState>(
        builder: (context, state) {
          return Stack(
            children: [
              VertifyWidget(
                callback: (phoneNumber) {
                  callbackPhone(phoneNumber);
                  if (state is VertifyPhoneInitial || countCubit.canResendSMS) {
                    context.read<VertifyPhoneBloc>().add(VertifyPhoneEvent(phoneNumber));
                  } else {
                    onToast('Too many request, please wait until ${countCubit.state.value} s', () {});
                  }
                },
                fieldController: fieldController,
                firstLabel: phoneViaLabel,
                secondLabel: phoneViaSubLabel,
                thirdLabel: phoneLabel,
              ),
            ],
          );
        },
      ),
    );
  }
}
