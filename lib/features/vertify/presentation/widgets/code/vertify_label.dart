import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/constants/labels/otp_label.dart';

import '../../../../../core/common_widget/header_label.dart';

class VertifyLabelWidget extends StatelessWidget {
  const VertifyLabelWidget({super.key, required this.agrument,});

  final String agrument;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderLabelWidget(
          title: otpLabel,
          subtitle: otpSubLabel.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 80,
          ),
          textAlign: TextAlign.center,
          subTextAlign: TextAlign.center,
          subStyle: Theme.of(context).textTheme.headlineSmall,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: buttonHeight, horizontal: buttonHeight * 1.5),
          child: Text(
            otpBotLabel + agrument,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
