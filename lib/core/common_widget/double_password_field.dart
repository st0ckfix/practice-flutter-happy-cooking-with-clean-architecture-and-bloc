import 'package:flutter/material.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/textfield_validation.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/common_widget/single_password_filed.dart';

import '../../../../../config/theme/size.dart';

class DoublePasswordField extends StatefulWidget {
  const DoublePasswordField({
    super.key,
    required this.confirmController,
    required this.passwordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmController;
  @override
  State<DoublePasswordField> createState() => _DoublePasswordFieldState();
}

class _DoublePasswordFieldState extends State<DoublePasswordField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: formHeight),
          child: SinglePasswordField(
            passwordController: widget.passwordController,
            label: passwordLabel,
            validator: passwordValidator,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: formHeight),
          child: SinglePasswordField(
            passwordController: widget.confirmController,
            label: passwordConfirmLabel,
            validator: (text) {
              return (text == null || text.isEmpty ) ? 'The field is required' : text == widget.passwordController.text ? null : 'Password not match';
            },
          ),
        ),
      ],
    );
  }
}
