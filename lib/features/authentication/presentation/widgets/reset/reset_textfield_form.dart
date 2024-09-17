import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/double_password_field.dart';

import '../../../../../config/theme/size.dart';

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
      child: Column(
        children: [
          DoublePasswordField(
            confirmController: confirmController,
            passwordController: passwordController,
          ),
          const SizedBox(height: formHeight),
          CustomButton(
            tag: null,
            isOutlined: false,
            icon: const SizedBox.shrink(),
            label: resetBtnLabel.toUpperCase(),
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
