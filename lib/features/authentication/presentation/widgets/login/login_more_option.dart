import 'package:flutter/material.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';

class LoginOptionWidget extends StatelessWidget {
  const LoginOptionWidget({
    super.key,
    required this.onCheckRemember,
    required this.onForgetPassword,
  });

  final Function(bool) onCheckRemember;
  final Function onForgetPassword;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) => onCheckRemember(value!),
              ),
              const Text(loginRememberLabel),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => onForgetPassword(),
            child: const Text(
              loginForgetPasswordLabel,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
