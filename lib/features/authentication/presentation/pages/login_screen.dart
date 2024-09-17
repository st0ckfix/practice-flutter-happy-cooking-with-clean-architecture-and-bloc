import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/authentication_routes.dart';
import 'package:happy_cooking/config/routes/vertify_routes.dart';
import 'package:happy_cooking/config/theme/color.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/constants/labels/error_label.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';
import 'package:happy_cooking/core/constants/labels/success_label.dart';
import 'package:happy_cooking/core/constants/tag.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/auth_switch.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/login/alternative_signin.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/login/login_textfield_form.dart';
import 'package:happy_cooking/shared-widget/loading_dialog.dart';
import 'package:happy_cooking/success_screen.dart';
import '../../../../core/common_widget/header_image.dart';
import '../../../../core/common_widget/header_label.dart';
import '../../../../core/constants/labels/sign_up_label.dart';
import '../../../../core/constants/textfield_validation.dart';
import '../../../../core/utils/function.dart';
import '../bloc/authentication/login_method/login_method_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      body: _buildBody(isDarkmode),
    );
  }

  _buildBody(bool isDarkmode) {
    log('LoginScreen/_buildBody');
    return BlocListener<LoginMethodBloc, LoginMethodState>(
      listener: (context, state) {
        if (state is LoginMethodSuccessful) {
          onToast(successLoginLabel, () {});
          Future.delayed(const Duration(seconds: 2)).then((value) {
            Get.offAll(() => const SuccessScreen());
          });
        } else if (state is LoginMethodFailed) {
          onToast(state.failedReason!, () {});
        } else if (state is LoginMethodException) {
          onToast(errorExceptionLabel, () {});
        }
      },
      child: BlocBuilder<LoginMethodBloc, LoginMethodState>(
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
                        title: loginWelcomeLabel,
                        subtitle: loginWelcomeSubLabel,
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900),
                        subStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      LoginTextfieldFormWidget(
                        callback: (email, password) {
                          context.read<LoginMethodBloc>().add(LoginWithEmailEvent(email, password));
                        },
                        onRemember: (value) {},
                        onForget: () {
                          //! Add Later
                          //Get.to(VertifyScreen(fieldValidator: emailValidator));
                        },
                      ),
                      AlternativeSignin(
                        isDarkmode: isDarkmode,
                        onGeust: () {
                          context.read<LoginMethodBloc>().add(const LoginAsGuestEvent());
                        },
                        onGoogle: () {
                          context.read<LoginMethodBloc>().add(const LoginWithGoogleEvent());
                        },
                        onPhone: () {
                          Get.toNamed(
                            VertifyRoutes.vertify,
                            arguments: {
                              'fieldValidator': phoneValidator,
                            },
                          );
                        },
                      ),
                      AuthSwitch(
                        label: loginDontHaveAnAccountLabel,
                        subLabel: signupBtnLabel,
                        onSwith: () => Get.offNamed(
                          AuthRoutes.signup,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is LoginMethodLoading) const LoadingIndicator()
            ],
          );
        },
      ),
    );
  }
}
