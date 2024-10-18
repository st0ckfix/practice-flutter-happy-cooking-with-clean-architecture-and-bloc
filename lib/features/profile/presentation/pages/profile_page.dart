import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../widgets/profile_list_menu_widget.dart';

final User user = FirebaseAuth.instance.currentUser!;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  bool isDarkmode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDarkmode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileInfoWidget(),
                ProfileListMenuWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
