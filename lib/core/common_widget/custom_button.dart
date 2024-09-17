import 'dart:math';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.tag,
    required this.isOutlined,
    required this.icon,
    required this.label,
    required this.onClick,
  });

  final String? tag;
  final bool isOutlined;
  final String label;
  final Widget icon;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? Random().nextInt(1000000),
      child: SizedBox(
        width: double.maxFinite,
        child: isOutlined
            ? OutlinedButton.icon(
                icon: icon,
                onPressed: () => onClick(),
                label: Text(label),
              )
            : ElevatedButton.icon(
                icon: icon,
                onPressed: () => onClick(),
                label: Text(label),
              ),
      ),
    );
  }
}
