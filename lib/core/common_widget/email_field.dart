import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_text_field.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/textfield_validation.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textEditingController: emailController,
      validator: emailValidator,
      hintText: emailLabel,
      labelText: emailLabel,
      prefixIcon: const Icon(Icons.email),
    );
  }
}
