import 'package:flutter/material.dart';

class LoadingItemWidget extends StatelessWidget {
  final double height;
  final double width;

  const LoadingItemWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

