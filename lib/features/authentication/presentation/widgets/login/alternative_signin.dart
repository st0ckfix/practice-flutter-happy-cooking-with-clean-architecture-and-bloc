import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/color.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/constants/images/images.dart';
import 'package:happy_cooking/core/constants/labels/log_in_label.dart';

class AlternativeSignin extends StatelessWidget {
  const AlternativeSignin({
    super.key,
    required this.isDarkmode,
    required this.onGoogle,
    required this.onPhone,
  });

  final bool isDarkmode;
  final Function onGoogle;
  final Function onPhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: buttonHeight),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              loginAlternativeLabel.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              circleIcon(isDarkmode, googleIcon, false, onGoogle),
              circleIcon(isDarkmode, phoneIcon, false, onPhone),
            ],
          ),
        ),
      ],
    );
  }
}

Widget circleIcon(bool isDarkmode, String icon, bool conditionColor, Function onSelect) {
  Color mainColor = isDarkmode ? Colors.white : secondaryColor;
  Color subColor = isDarkmode ? secondaryColor : Colors.white;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: formHeight),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.fromBorderSide(
        BorderSide(width: 1.5, color: mainColor),
      ),
      color: subColor,
    ),
    child: IconButton(
      onPressed: () => onSelect(),
      icon: Image.asset(
        icon,
        height: 30,
        width: 30,
        color: conditionColor ? mainColor : null,
      ),
    ),
  );
}
