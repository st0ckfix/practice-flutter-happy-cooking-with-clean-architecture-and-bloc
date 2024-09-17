import 'package:flutter/material.dart';

class AuthSwitch extends StatelessWidget {
  const AuthSwitch({
    super.key,
    required this.label,
    required this.subLabel,
    required this.onSwith,
  });

  final String label;
  final String subLabel;
  final Function onSwith;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          TextButton(
            onPressed: () => onSwith(),
            child: Text(
              subLabel,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
