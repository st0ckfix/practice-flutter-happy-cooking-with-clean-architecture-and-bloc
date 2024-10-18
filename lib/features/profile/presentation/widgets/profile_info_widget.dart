import 'package:flutter/material.dart';

import 'image/image_widget.dart';
import 'username/username_widget.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget({
    super.key,
  });

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ImageWidget(),
        UsernameWidget(),
      ],
    );
  }
}
