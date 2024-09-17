import 'package:flutter/material.dart';
import '../../../../../core/common_widget/custom_text_field.dart';

class SinglePasswordField extends StatefulWidget {
  const SinglePasswordField({
    super.key,
    required this.passwordController,
    required this.label,
    required this.validator
  });

  final TextEditingController passwordController;
  final String label;
  final String? Function(String?) validator;

  @override
  State<SinglePasswordField> createState() => _SinglePasswordFieldState();
}

class _SinglePasswordFieldState extends State<SinglePasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textEditingController: widget.passwordController,
      validator: widget.validator,
      hintText: widget.label,
      labelText: widget.label,
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
      ),
      obscureText: obscureText,
    );
  }
}
