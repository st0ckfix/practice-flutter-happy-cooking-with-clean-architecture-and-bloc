import 'package:flutter/material.dart';

class InkWellTextWidget extends Text {
  const InkWellTextWidget(
    super.data, {
    super.key,
    this.margin,
    this.padding,
    required this.onClick,
    this.textStyle,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function onClick;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: margin,
        padding: padding,
        alignment: Alignment.center,
        child: InkWell(
          onTap: () => onClick(),
          child: Text(
            super.data!,
            style: textStyle ??
                Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
          ),
        ),
      ),
    );
  }
}
