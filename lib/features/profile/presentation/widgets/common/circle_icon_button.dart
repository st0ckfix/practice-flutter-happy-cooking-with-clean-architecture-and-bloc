import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.leading,
    this.circleSize,
    this.iconSize,
    this.verticalPadding,
    this.horizontalPadding,
    this.backgroundColor,
    this.foregroundColor,
    this.callback,
  });

  final IconData leading;
  final double? circleSize;
  final double? iconSize;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleSize ?? 40,
      width: circleSize ?? 40,
      margin: EdgeInsets.symmetric(vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Theme.of(context).colorScheme.primary.withOpacity(.2),
      ),
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () => callback!(),
        icon: Icon(
          leading,
          color: foregroundColor ?? Theme.of(context).colorScheme.primary,
          size: iconSize ?? 25,
        ),
      ),
    );
  }
}
