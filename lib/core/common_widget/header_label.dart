import 'package:flutter/material.dart';
import 'package:happy_cooking/core/utils/extention.dart';

class HeaderLabelWidget extends StatelessWidget {
  const HeaderLabelWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.style,
    this.subStyle,
    this.textAlign,
    this.subTextAlign,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  final String title;
  final String? subtitle;
  final TextStyle? style;
  final TextStyle? subStyle;
  final TextAlign? textAlign;
  final TextAlign? subTextAlign;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: style.let((it) => it.copyWith(height: 1)),
            textAlign: textAlign,
          ),
          if(subtitle != null)
          Text(
            subtitle!,
            style: subStyle,
            textAlign: subTextAlign,
          ),
        ],
      ),
    );
  }
}
