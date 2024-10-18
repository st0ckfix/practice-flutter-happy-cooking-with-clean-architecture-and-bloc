import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';

import '../../../../../config/theme/size.dart';
import '../../../../../core/common_widget/double_password_field.dart';

class ResetTextfieldWidget extends StatelessWidget {
  ResetTextfieldWidget({
    super.key,
    required this.callback,
  });

  final Function(String) callback;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          DoublePasswordField(
            confirmController: confirmController,
            passwordController: passwordController,
          ),
          const SizedBox(height: formHeight),
          CustomButton(
            isOutlined: false,
            title: 'NEXT',
            onClick: () {
              if (!globalKey.currentState!.validate()) return;
              callback(passwordController.text);
            },
          ),
        ],
      ),
    );
  }
}
