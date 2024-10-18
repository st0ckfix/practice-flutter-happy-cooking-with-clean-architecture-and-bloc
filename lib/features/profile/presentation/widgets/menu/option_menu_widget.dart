import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/authentication_routes.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/logout/logout_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/pages/profile_page.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/menu/profile_menu_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

class OptionMenuWidget extends StatelessWidget {
  const OptionMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
          if (state is LogoutSuccessful) {
            onToast('Logout Successful', () {
              Get.offAllNamed(AuthRoutes.welcome);
            });
          } else if (state is LogoutFailed) {
            onToast(state.failedReason!, () {});
          }
        }
      },
      child: Column(
        children: [
          ProfileMenuWidget(
            leading: Icons.clear,
            trailing: false,
            title: 'Delete Account',
            callback: () {},
            textColor: Colors.red,
          ),
          ProfileMenuWidget(
            leading: LineAwesomeIcons.sign_out_alt_solid,
            trailing: false,
            title: 'Logout',
            callback: () {
              if (user.isAnonymous) {
                context.read<LogoutBloc>().add(const LogoutEvent());
              } else {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                context.read<LogoutBloc>().add(const LogoutEvent());
                              },
                              child: const Text('Yes')),
                        ],
                        title: Padding(
                          padding: const EdgeInsets.all(formHeight),
                          child: Text(
                            'To make sure that you want to Log Out ?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    });
              }
            },
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
