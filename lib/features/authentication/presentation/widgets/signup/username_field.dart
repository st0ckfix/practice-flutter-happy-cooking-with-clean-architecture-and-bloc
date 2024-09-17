import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/textfield_validation.dart';

import '../../../../../core/common_widget/custom_text_field.dart';


class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    required this.usernameController,
  });

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    log('SignUp / UsernameField / build');
    return CustomTextField(
      textEditingController: usernameController,
      validator: usernameValidator,
      hintText: usernameLabel,
      labelText: usernameLabel,
      prefixIcon: const Icon(Icons.person),
    );
  }
}
