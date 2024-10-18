import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';

import '../../../../../core/common_widget/header_image.dart';
import '../../../../../core/common_widget/header_label.dart';
import '../../../../../core/common_widget/password_textfield_form.dart';
import '../../../../../core/constants/labels/welcome_label.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key, required this.callback});

  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              const HeaderImageWidget(
                key: Key(welcomeLabel),
                height: 100,
                color: null,
              ),
              HeaderLabelWidget(
                title: 'Complete password',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900),
                textAlign: TextAlign.start,
              ),
              ResetTextfieldWidget(
                callback: (password) => callback(password),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
