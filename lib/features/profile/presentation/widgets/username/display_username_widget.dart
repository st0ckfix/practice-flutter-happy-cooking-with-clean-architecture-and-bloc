import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../common/circle_icon_button.dart';

class DisplayUsernameWidget extends StatelessWidget {
  const DisplayUsernameWidget({super.key, required this.callback, required this.display});

  final String display;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          display,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        CircleIconButton(
          leading: LineAwesomeIcons.pencil_alt_solid,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
          foregroundColor: Theme.of(context).colorScheme.primary,
          circleSize: 35,
          iconSize: 20,
          horizontalPadding: formHeight,
          callback: () => callback(),
        ),
      ],
    );
  }
}
