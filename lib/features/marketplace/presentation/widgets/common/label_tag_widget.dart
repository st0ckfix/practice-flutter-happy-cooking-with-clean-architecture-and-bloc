import 'package:flutter/material.dart';

class LabelTagWidget extends StatelessWidget {
  const LabelTagWidget({
    super.key,
    required this.title,
    this.textStyle,
    this.boxDecoration,
    this.margin,
    this.padding,
    this.boxColor,
    this.textColor,
  });

  final String title;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? boxColor;
  final BoxDecoration? boxDecoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(5),
      padding: padding ?? const EdgeInsets.all(5),
      decoration: boxDecoration ??
           BoxDecoration(
            color: boxColor,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: textStyle ?? const TextStyle(color: Colors.white),
      ),
    );
  }

  factory LabelTagWidget.goldTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        color: Color(0xFFFFD700),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      margin: margin,
      padding: padding,
    );
  }

  factory LabelTagWidget.platinumTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        color: Color(0xFFE5E4E2),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      margin: margin,
      padding: padding,
    );
  }

  factory LabelTagWidget.diamonTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        color: Color(0xFFB9F2FF),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      margin: margin,
      padding: padding,
    );
  }

  factory LabelTagWidget.deliveryCouponTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        color: Color.fromARGB(255, 95, 183, 255),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      margin: margin,
      padding: padding,
    );
  }

  factory LabelTagWidget.productCouponTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        color: Color(0xFF368f8b),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      margin: margin,
      padding: padding,
    );
  }

  factory LabelTagWidget.discountTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? fontSize,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: textStyle ?? TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSize ?? 10),
      margin: margin,
      padding: padding,
    );
  }

  factory LabelTagWidget.fireTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? fontSize,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xffa10100),
          Color(0xffda1f05),
          Color(0xfff33c04),
          Color(0xfffe650d),
          Color(0xffffc11f),
          Color(0xfffff75d),
        ]),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: textStyle ?? TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSize ?? 10),
      margin: margin ?? EdgeInsets.zero,
      padding: padding,
    );
  }

  factory LabelTagWidget.tokenBonusTag(
    String title, {
    EdgeInsets? margin,
    EdgeInsets? padding,
  }) {
    return LabelTagWidget(
      title: title,
      boxDecoration: BoxDecoration(
        color: Colors.yellow.shade800,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      margin: margin,
      padding: padding,
    );
  }
}
