import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/constants/images/images.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    tzuyuAvatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                  ),
                  child: Icon(
                    LineAwesomeIcons.camera_solid,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: formHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tzuyu',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  width: formHeight,
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                  ),
                  child: Icon(
                    LineAwesomeIcons.pencil_alt_solid,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
