import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:happy_cooking/core/constants/labels/common_label.dart';
import 'package:happy_cooking/core/constants/textfield_validation.dart';
import '../../../../../core/common_widget/custom_text_field.dart';

class VertifyTextfieldWidget extends StatelessWidget {
  VertifyTextfieldWidget({
    super.key,
    required this.label,
    required this.callback,
    required this.fieldController,
  });

  final String label;
  final Function(String) callback;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController fieldController;

  @override
  Widget build(BuildContext context) {
    log('VertifyScreen / VertifyTextfieldWidget / build');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: buttonHeight),
          child: Form(
            key: globalKey,
            child: CustomTextField(
              textEditingController: fieldController,
              validator: label == emailLabel ? emailValidator : phoneValidator,
              hintText: label,
              labelText: label,
              prefixIcon: Icon(label == emailLabel ? Icons.email : Icons.phone_android),
              textInputType: label == emailLabel ? TextInputType.emailAddress : TextInputType.phone,
            ),
          ),
        ),
        CustomButton(
          tag: null,
          isOutlined: false,
          icon: const SizedBox.shrink(),
          label: nextLabel.toUpperCase(),
          onClick: () {
            if (!globalKey.currentState!.validate()) return;
            callback(fieldController.text);
          },
        ),
      ],
    );
  }
}
