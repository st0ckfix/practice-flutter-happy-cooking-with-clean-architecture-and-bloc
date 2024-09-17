import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/tag.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/login_screen.dart';
import 'package:happy_cooking/features/authentication/presentation/pages/signup_screen.dart';

import '../../../../../core/constants/labels/log_in_label.dart';
import '../../../../../core/constants/labels/sign_up_label.dart';

class WelcomeNavigation extends StatelessWidget {
  const WelcomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            key: const Key(loginTag),
            isOutlined: true,
            label: loginBtnLabel.toUpperCase(),
            icon: const SizedBox.shrink(),
            onClick: () {
              Get.to(() => const LoginScreen());
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomButton(
            isOutlined: false,
            key: const Key(signupTag),
            label: signupBtnLabel.toUpperCase(),
            icon: const SizedBox.shrink(),
            onClick: () {
              Get.to(() => const SignupScreen());
            },
          ),
        ),
      ],
    );
  }
}
