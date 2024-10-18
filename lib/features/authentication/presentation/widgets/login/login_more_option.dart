import 'package:flutter/material.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';

class LoginOptionWidget extends StatelessWidget {
  const LoginOptionWidget({
    super.key,
    required this.onForgetPassword,
  });

  final Function onForgetPassword;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => onForgetPassword(),
        child: const Text(
          loginForgetPasswordLabel,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
