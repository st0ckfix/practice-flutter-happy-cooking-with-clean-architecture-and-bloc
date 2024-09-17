import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.textColor,
    required this.callback,
  });

  final IconData leading;
  final IconData? trailing;
  final String title;
  final Color? textColor;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary.withOpacity(.2),
        ),
        child: Icon(
          leading,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
      trailing: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(.3),
        ),
        child: Icon(
          trailing,
          color: Colors.grey,
        ),
      ),
    );
  }
}
