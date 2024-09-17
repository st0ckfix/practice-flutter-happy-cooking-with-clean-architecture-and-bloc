import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/color.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/constants/labels/welcome_label.dart';
import 'package:happy_cooking/core/constants/tag.dart';
import 'package:happy_cooking/features/authentication/presentation/widgets/welcome/navigation.dart';

import '../../../../core/common_widget/header_image.dart';
import '../../../../core/common_widget/header_label.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final darkmode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darkmode ? secondaryColor : Colors.lightBlue.shade200,
      body: LayoutBuilder(builder: (_, constraints) {
        return Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderImageWidget(
                key: const Key(welcomeTag),
                height: constraints.maxHeight * .5,
                color: Colors.white,
              ),
              HeaderLabelWidget(
                title: welcomeLabel,
                subtitle: welcomeSubLabel,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w900),
                subStyle: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                subTextAlign: TextAlign.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              const WelcomeNavigation(),
            ],
          ),
        );
      }),
    );
  }
}
