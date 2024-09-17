import 'package:flutter/material.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/profile_menu_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListMenuWidget extends StatelessWidget {
  const ProfileListMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainMenuWidget(
        ),
        const Divider(
          height: 1,
          thickness: 2,
        ),
        LinkingAccountMenuWidget(
        ),
        const Divider(
          height: 1,
          thickness: 2,
        ),
        SupportMenuWidget(
        ),
        const Divider(
          height: 1,
          thickness: 2,
        ),
        OptionMenuWidget(
        ),
      ],
    );
  }
}

class OptionMenuWidget extends StatelessWidget {
  const OptionMenuWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuWidget(
          leading: Icons.clear,
          title: 'Delete Account',
          callback: (){},
          textColor: Colors.red,
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.sign_out_alt_solid,
          title: 'Logout',
          callback: () {},
          textColor: Colors.red,
        ),
      ],
    );
  }
}

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuWidget(
          leading: LineAwesomeIcons.cog_solid,
          title: 'Settings',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: (){},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.wallet_solid,
          title: 'Billing',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: (){},
        ),
      ],
    );
  }
}

class SupportMenuWidget extends StatelessWidget {
  const SupportMenuWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuWidget(
          leading: LineAwesomeIcons.user_check_solid,
          title: 'User Manangement',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: () {},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.info_solid,
          title: 'Infomation',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: () {},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.mail_bulk_solid,
          title: 'Contact/Support',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: () {},
        ),
      ],
    );
  }
}

class LinkingAccountMenuWidget extends StatelessWidget {
  const LinkingAccountMenuWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuWidget(
          leading: Icons.email_outlined,
          title: 'Link Email Account',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: (){},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.google,
          title: 'Link Google Account',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: (){},
        ),
        ProfileMenuWidget(
          leading: Icons.phone_android,
          title: 'Link Phone',
          trailing: LineAwesomeIcons.angle_right_solid,
          callback: (){},
        ),
      ],
    );
  }
}
