import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(.5),
      child: const Align(
        alignment: Alignment.center,
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
