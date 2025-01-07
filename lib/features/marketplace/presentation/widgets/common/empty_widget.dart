import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Center(
        child: Text('Found no products'),
      ),
    );
  }
}