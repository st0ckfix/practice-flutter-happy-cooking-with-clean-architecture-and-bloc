import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/labels/error_label.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/single_password_filed.dart';

import '../../../../../config/theme/size.dart';
import '../../../../../core/constants/tag.dart';
import '../common_widget/email_field.dart';
import 'login_more_option.dart';

class LoginTextfieldFormWidget extends StatelessWidget {
  LoginTextfieldFormWidget({
    super.key,
    required this.callback,
    required this.onForget,
    required this.onRemember,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final Function(String, String) callback;
  final Function(bool) onRemember;
  final Function onForget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: formHeight),
      width: double.maxFinite,
      child: Form(
        key: globalKey,
        child: Column(
          children: [
            EmailField(
              emailController: emailController,
            ),
            const SizedBox(height: formHeight),
            SinglePasswordField(
              passwordController: passwordController,
              label: passwordLabel,
              validator: (text) {
                return text == null || text.isEmpty ? errorEmptyLabel : null;
              },
            ),
            const SizedBox(height: formHeight),
            LoginOptionWidget(
              onCheckRemember: (bool value) => onRemember(value),
              onForgetPassword: () => onForget(),
            ),
            const SizedBox(height: formHeight),
            CustomButton(
              key: const Key(loginTag),
              isOutlined: true,
              icon: const SizedBox.shrink(),
              label: loginBtnLabel.toUpperCase(),
              onClick: () {
                if (!globalKey.currentState!.validate()) return;
                callback(emailController.text, passwordController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
