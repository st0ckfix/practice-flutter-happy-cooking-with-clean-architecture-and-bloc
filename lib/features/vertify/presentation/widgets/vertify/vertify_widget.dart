import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/common_widget/header_image.dart';
import 'package:happy_cooking/core/common_widget/header_label.dart';
import 'package:happy_cooking/core/constants/labels/welcome_label.dart';
import 'package:happy_cooking/features/vertify/presentation/widgets/vertify/verify_textfield_form.dart';

class VertifyWidget extends StatelessWidget {
  const VertifyWidget({
    super.key,
    required this.callback,
    required this.fieldController,
    this.firstLabel,
    this.secondLabel,
    this.thirdLabel,
  });

  final String? firstLabel;
  final String? secondLabel;
  final String? thirdLabel;
  final TextEditingController fieldController;
  final Function(String) callback;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderImageWidget(
                key: Key(welcomeLabel),
                height: 100,
                color: null,
              ),
              HeaderLabelWidget(
                title: firstLabel ?? '',
                subtitle: secondLabel ?? '',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900),
                subStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
              VertifyTextfieldWidget(
                label: thirdLabel ?? '',
                fieldController: fieldController,
                callback: (value) => callback(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
