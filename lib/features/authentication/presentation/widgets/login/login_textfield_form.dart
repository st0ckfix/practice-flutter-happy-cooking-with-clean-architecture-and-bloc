import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/labels/error_label.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/single_password_filed.dart';

import '../../../../../config/theme/size.dart';
import '../../../../../core/common_widget/email_field.dart';
import '../../../../../core/constants/tag.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: formHeight),
              child: EmailField(
                emailController: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: formHeight),
              child: SinglePasswordField(
                passwordController: passwordController,
                label: passwordLabel,
                validator: (text) {
                  return text == null || text.isEmpty ? errorEmptyLabel : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: formHeight),
              child: LoginOptionWidget(
                onForgetPassword: () => onForget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: formHeight),
              child: CustomButton(
                key: const Key(loginTag),
                isOutlined: true,
                title: loginBtnLabel.toUpperCase(),
                onClick: () {
                  if (!globalKey.currentState!.validate()) return;
                  callback(emailController.text, passwordController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
