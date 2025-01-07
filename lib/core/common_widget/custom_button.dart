import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isOutlined,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.leading,
    this.trailing,
    this.title,
    this.fontWeight = FontWeight.bold,
    this.fontStyle = FontStyle.normal,
    this.fontSize = 13,
    this.fontColor = Colors.white,
    this.shape,
    required this.onClick,
  });

  final bool isOutlined;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final Color? fontColor;
  final OutlinedBorder? shape;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: isOutlined
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: padding,
                minimumSize: Size.zero,
                shape: shape,
              ),
              onPressed: () => onClick(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                        fontWeight: fontWeight,
                        fontStyle: fontStyle,
                        fontSize: fontSize,
                        color: fontColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (trailing != null) trailing!,
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: padding,
                minimumSize: Size.zero,
                shape: shape,
              ),
              onPressed: () => onClick(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                        fontWeight: fontWeight,
                        fontStyle: fontStyle,
                        fontSize: fontSize,
                        color: fontColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
    );
  }
}
