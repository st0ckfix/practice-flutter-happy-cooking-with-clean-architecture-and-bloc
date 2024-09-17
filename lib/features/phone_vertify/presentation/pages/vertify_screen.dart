import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/vertify_routes.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/labels/vertify_label.dart';
import 'package:happy_cooking/core/constants/labels/welcome_label.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/email_vertify/email_vertify_bloc.dart';
import 'package:happy_cooking/features/phone_vertify/presentation/bloc/phone_vertify/phone_vertify_bloc.dart';

import '../../../../config/theme/color.dart';
import '../../../../config/theme/size.dart';
import '../../../../core/common_widget/header_image.dart';
import '../../../../core/common_widget/header_label.dart';
import '../widgets/vertify/verify_textfield_form.dart';
import 'vertify_page.dart';

class VertifyScreen extends StatefulWidget {
  const VertifyScreen({
    super.key,
    this.email,
    required this.fieldValidator,
  });

  final String? email;
  final String? Function(String?) fieldValidator;

  @override
  State<VertifyScreen> createState() => _VertifyScreenState();
}

class _VertifyScreenState extends State<VertifyScreen> {
  late Brightness brightness;
  late bool isDarkmode;
  final fieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkmode = brightness == Brightness.dark;
  }

  late String agrument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkmode ? secondaryColor : Colors.white,
      body: _buildBody(isDarkmode),
    );
  }

  _buildBody(bool isDarkmode) {
    log('VerifyScreen/_buildBody');
    return MultiBlocListener(
      listeners: [
        BlocListener<PhoneVertifyBloc, PhoneVertifyState>(
          listener: (context, state) {
            if (ModalRoute.of(context)?.isCurrent ?? false) {
              if (state is PhoneVertifyRequestDone) {
                log('current screen');
                countCubit.onChangeResendState(false);
                countCubit.runCubit();
                Get.toNamed(VertifyRoutes.smsVertify, arguments: {
                  'agrument': agrument,
                  'resendSMS': () {
                    sendSMS(agrument, false);
                  },
                });
              }
            }
          },
        ),
        BlocListener<EmailVertifyBloc, EmailVertifyState>(
          listener: (context, state) {
            if (ModalRoute.of(context)?.isCurrent ?? false) {
              if (state is EmailVertifySuccessful) {
                log('current screen');
                countCubit.onChangeResendState(false);
                countCubit.runCubit();
                Get.toNamed(VertifyRoutes.smsVertify, arguments: {
                  'agrument': agrument,
                  'resendSMS': () {
                    sendSMS(agrument, true);
                  },
                });
              }
            }
          },
        ),
      ],
      child: widget.email != null
          ? BlocBuilder<EmailVertifyBloc, EmailVertifyState>(
              builder: (context, state) {
                return VertifyWidget(
                  callback: (text) {
                    if (state is EmailVertifyInitial || countCubit.canResendSMS) {
                      sendSMS(text, true);
                    } else {
                      onToast('Too many request, please wait until //${countCubit.state.value} s', () {});
                    }
                  },
                  fieldController: fieldController,
                  firstLabel: emailViaLabel,
                  secondLabel: emailViaSubLabel,
                  thirdLabel: emailLabel,
                );
              },
            )
          : BlocBuilder<PhoneVertifyBloc, PhoneVertifyState>(
              builder: (context, state) {
                return VertifyWidget(
                  callback: (text) {
                    if (state is PhoneVertifyInitial || countCubit.canResendSMS) {
                      sendSMS(text, false);
                    } else {
                      onToast('Too many request, please wait until ${countCubit.state.value} s', () {});
                    }
                  },
                  fieldController: fieldController,
                  firstLabel: phoneViaLabel,
                  secondLabel: phoneViaSubLabel,
                  thirdLabel: phoneLabel,
                );
              },
            ),
    );
  }

  void sendSMS(String agrument, bool isEmail) {
    isEmail ? context.read<EmailVertifyBloc>().add(EmailVertifyEvent(agrument)) : context.read<PhoneVertifyBloc>().add(PhoneVertifyEvent(agrument));
  }
}

class VertifyWidget extends StatelessWidget {
  const VertifyWidget({
    super.key,
    required this.callback,
    required this.fieldController,
    this.firstLabel,
    this.secondLabel,
    this.thirdLabel,
  });

  final String? firstLabel;
  final String? secondLabel;
  final String? thirdLabel;
  final TextEditingController fieldController;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderImageWidget(
                  key: Key(welcomeLabel),
                  height: 100,
                  color: null,
                ),
                HeaderLabelWidget(
                  title: firstLabel ?? '',
                  subtitle: secondLabel ?? '',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900),
                  subStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
                VertifyTextfieldWidget(
                  label: thirdLabel ?? '',
                  fieldController: fieldController,
                  callback: (value) => callback(value),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
