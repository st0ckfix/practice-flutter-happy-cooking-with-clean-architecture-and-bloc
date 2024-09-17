import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as gtx;
import 'package:happy_cooking/config/routes/authentication_routes.dart';
import 'package:happy_cooking/core/constants/labels/error_label.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';
import 'package:happy_cooking/core/constants/labels/sign_up_label.dart';
import 'package:happy_cooking/core/constants/labels/success_label.dart';
import 'package:happy_cooking/core/constants/tag.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/authentication/presentation/bloc/authentication/signup_user/signup_user_bloc.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/login_screen.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/auth_switch.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/signup/signup_textfield_form.dart';
import 'package:happy_cooking/shared-widget/loading_dialog.dart';

import '../../../../config/theme/color.dart';
import '../../../../config/theme/size.dart';
import '../../../../core/common_widget/header_image.dart';
import '../../../../core/common_widget/header_label.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Brightness brightness;
  late bool isDarkmode;

  @override
  void initState() {
    super.initState();
    brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkmode = brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkmode ? secondaryColor : Colors.white,
      body: _buildBody(),
    );
  }

  _buildBody() {
    log("SignupScreen.dart: _buildBody");
    return BlocListener<SignupUserBloc, SignupUserState>(
      listener: (context, state) {
        if (state is SignupUserSuccessful) {
          onToast(successLoginLabel, () {});
          Future.delayed(const Duration(seconds: 2)).then((value) {
            gtx.Get.off(() => const LoginScreen());
          });
        } else if (state is SignupUserFailed) {
          onToast(state.failedReason!, () {});
        } else if (state is SignupUserException) {
          onToast(errorExceptionLabel, () {});
        }
      },
      child: BlocBuilder<SignupUserBloc, SignupUserState>(
        builder: (context, state) {
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
                        key: Key(welcomeTag),
                        height: 100,
                      ),
                      HeaderLabelWidget(
                        title: signupWelcomeLabel,
                        subtitle: signupWelcomeSubLabel,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900),
                        subStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SignupTextfieldFormWidget(
                        callback: (email, password, username) {
                          context.read<SignupUserBloc>().add(SignupUserEvent(email, password, username));
                        },
                      ),
                      AuthSwitch(
                        label: signupAlreadyHaveAnAccountLabel,
                        subLabel: loginBtnLabel,
                        onSwith: () => gtx.Get.offNamed(AuthRoutes.login),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is SignupUserLoading) const LoadingIndicator()
            ],
          );
        },
      ),
    );
  }
}
