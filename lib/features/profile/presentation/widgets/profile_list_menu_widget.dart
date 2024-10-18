import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/link_account_with_credential/link_account_with_credential_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/menu/option_menu_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'menu/linking_account_menu_widget.dart';
import 'menu/profile_menu_widget.dart';

class ProfileListMenuWidget extends StatelessWidget {
  const ProfileListMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LinkAccountWithCredentialBloc, LinkAccountWithCredentialState>(
      listener: (context, state) {
        if (state is LinkAccountWithCredentialLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      child: const Column(
        children: [
          MainMenuWidget(),
          Divider(height: 1, thickness: 2),
          LinkingAccountMenuWidget(),
          Divider(height: 1, thickness: 2),
          SupportMenuWidget(),
          Divider(height: 1, thickness: 2),
          OptionMenuWidget(),
        ],
      ),
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
          trailing: true,
          title: 'Settings',
          callback: () {},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.wallet_solid,
          title: 'Billing',
          trailing: true,
          callback: () {},
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
          trailing: true,
          callback: () {},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.info_solid,
          title: 'Infomation',
          trailing: true,
          callback: () {},
        ),
        ProfileMenuWidget(
          leading: LineAwesomeIcons.mail_bulk_solid,
          title: 'Contact/Support',
          trailing: true,
          callback: () {},
        ),
      ],
    );
  }
}
