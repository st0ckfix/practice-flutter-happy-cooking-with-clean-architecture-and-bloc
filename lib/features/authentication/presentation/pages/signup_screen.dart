import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/authentication_routes.dart';
import 'package:happy_cooking/config/routes/vertify_routes.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';
import 'package:happy_cooking/core/constants/labels/sign_up_label.dart';
import 'package:happy_cooking/core/constants/labels/success_label.dart';
import 'package:happy_cooking/core/constants/tag.dart';
import 'package:happy_cooking/core/constants/textfield_validation.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/authentication/presentation/bloc/authentication/signup_user/signup_user_bloc.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/auth_switch.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/signup/signup_textfield_form.dart';
import 'package:happy_cooking/features/vertify/presentation/pages/vertify_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
        if (state is SignupUserLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
          if (state is SignupUserSuccessful) {
            onToast(successSignupLabel, () {});
            Future.delayed(const Duration(seconds: 2)).then((value) {
              Get.offNamedUntil(AuthRoutes.login, (route) => route.isFirst);
            });
          }
          if (state is SignupUserFailed) {
            onToast(state.failedReason!, () {});
          }
        }
      },
      child: BlocBuilder<SignupUserBloc, SignupUserState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(defaultSize),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          subStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w300),
                          textAlign: TextAlign.start,
                        ),
                        SignupTextfieldFormWidget(
                          callback: (email, password, username) {
                            Get.toNamed(VertifyRoutes.vertify, arguments: {
                              'form': VertifyForm.email,
                              'email': email,
                              'callback': () {
                                context.read<SignupUserBloc>().add(SignupUserEvent(email, password, username));
                              },
                              'fieldValidator': emailValidator,
                            });
                          },
                        ),
                        AuthSwitch(
                          label: signupAlreadyHaveAnAccountLabel,
                          subLabel: loginBtnLabel,
                          onSwith: () => Get.offNamed(AuthRoutes.login),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
