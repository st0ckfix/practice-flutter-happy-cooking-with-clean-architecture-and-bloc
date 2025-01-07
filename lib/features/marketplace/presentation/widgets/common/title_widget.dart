import 'package:flutter/material.dart';

class TitleWidget extends Text {
  const TitleWidget(super.data, {super.key, this.magin, this.padding, this.color});
  final EdgeInsets? magin;
  final EdgeInsets? padding;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: magin ?? const EdgeInsets.all(5),
      padding: padding,
      child: Text(
        super.data!,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
