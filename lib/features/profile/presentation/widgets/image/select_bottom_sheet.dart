import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/image/media_select_widget.dart';
import 'package:image_picker/image_picker.dart';

class SelectBottomSheet extends StatelessWidget {
  const SelectBottomSheet({super.key, required this.callback});

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultSize),
      child: Row(
        children: [
          MediaSelectWidget(
            source: ImageSource.camera,
            iconData: Icons.camera_alt_outlined,
            title: 'Camera',
            callback: () => callback(),
          ),
          MediaSelectWidget(
            source: ImageSource.gallery,
            iconData: Icons.image,
            title: 'Gallery',
            callback: () => callback(),
          )
        ],
      ),
    );
  }
}
