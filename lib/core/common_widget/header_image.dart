import 'package:flutter/material.dart';
import 'package:happy_cooking/core/constants/images/images.dart';

class HeaderImageWidget extends StatelessWidget {
  const HeaderImageWidget({super.key, this.color, this.height});

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: key!,
      transitionOnUserGestures: true,
      child: SizedBox(
        height: height,
        width: double.maxFinite,
        child: Stack(
          children: [
            Image.asset(
              splashIcon,
              color: color ?? Colors.lightBlue.shade200,
            ),
            Image.asset(
              welcomeImage,
            ),
          ],
        ),
      ),
    );
  }
}