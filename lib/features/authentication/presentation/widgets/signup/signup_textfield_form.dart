import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/labels/sign_up_label.dart';
import '../../../../../core/common_widget/double_password_field.dart';
import '../../../../../core/common_widget/email_field.dart';
import '../../../../../core/constants/tag.dart';
import 'username_field.dart';

class SignupTextfieldFormWidget extends StatelessWidget {
  SignupTextfieldFormWidget({super.key, required this.callback});

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final Function(String, String, String) callback;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            child: DoublePasswordField(
              confirmController: confirmController,
              passwordController: passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: formHeight),
            child: UsernameField(
              usernameController: usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: formHeight),
            child: CustomButton(
              key: const Key(signupTag),
              isOutlined: false,
              title: signupBtnLabel,
              onClick: () {
                if (!globalKey.currentState!.validate()) return;
                callback(emailController.text, passwordController.text, usernameController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
