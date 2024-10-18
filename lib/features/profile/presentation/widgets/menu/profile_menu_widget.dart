import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../common/circle_icon_button.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.leading,
    required this.title,
    required this.trailing,
    this.textColor,
    required this.callback,
  });

  final IconData leading;
  final bool trailing;
  final String title;
  final Color? textColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleIconButton(leading: leading),
      title: InkWell(
        onTap: () {
          if (!trailing) callback();
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      trailing: trailing
          ? Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(.3),
              ),
              child: IconButton(
                onPressed: () => callback(),
                icon: const Icon(
                  LineAwesomeIcons.angle_right_solid,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            )
          : null,
    );
  }
}
