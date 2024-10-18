import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/routes/profile_routes.dart';
import 'package:happy_cooking/config/routes/vertify_routes.dart';
import 'package:happy_cooking/core/constants/textfield_validation.dart';
import 'package:happy_cooking/core/utils/extention.dart';
import 'package:happy_cooking/core/utils/function.dart';
import 'package:happy_cooking/features/profile/presentation/pages/profile_page.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/password/update_password_screen.dart';
import 'package:happy_cooking/features/vertify/presentation/pages/vertify_screen.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../bloc/link_account_with_credential/link_account_with_credential_bloc.dart';
import 'profile_menu_widget.dart';

class LinkingAccountMenuWidget extends StatefulWidget {
  const LinkingAccountMenuWidget({
    super.key,
  });

  @override
  State<LinkingAccountMenuWidget> createState() => _LinkingAccountMenuWidgetState();
}

class _LinkingAccountMenuWidgetState extends State<LinkingAccountMenuWidget> {
  List<UserInfo>? userInfo;
  UserInfo? email;
  UserInfo? phone;
  UserInfo? google;
  String? emailDisplay;
  String? phoneDisplay;
  String? googleDisplay;

  @override
  void initState() {
    super.initState();
    initSigninMethod();
  }

  void initSigninMethod() {
    userInfo = user.providerData;
    try {
      email ??= userInfo!.firstWhere((element) => element.providerId == 'password');
      emailDisplay ??= email.let((it) => it.email!.replaceRange(it.email!.length > 8 ? 2 : 1, it.email!.indexOf('@') - (it.email!.length > 8 ? 2 : 1), '****'));
    } catch (e) {
      email = null;
    }
    try {
      phone ??= userInfo!.firstWhere((element) => element.providerId == 'phone');
      phoneDisplay ??= phone.let((it) => it.phoneNumber!.replaceRange(3, 7, '***'));
    } catch (e) {
      phone = null;
    }
    try {
      google ??= userInfo!.firstWhere((element) => element.providerId == 'google.com');
      googleDisplay ??= google.let((it) => it.email!.replaceRange(it.email!.length > 8 ? 2 : 1, it.email!.indexOf('@') - (it.email!.length > 8 ? 2 : 1), '****'));
    } catch (e) {
      google = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LinkAccountWithCredentialBloc, LinkAccountWithCredentialState>(
      listener: (context, state) {
        if (state is LinkAccountWithCredentialLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
          if (state is LinkAccountWithCredentialSuccessful) {
            Get.offNamedUntil(ProfileRoutes.profile, (route) => route.isCurrent);
            setState(() {
              onToast('Link Account Successful', () {});
              initSigninMethod();
            });
          } else if (state is LinkAccountWithCredentialFailed) {
            setState(() => onToast(state.failedReason!, () {}));
          }
        }
      },
      child: Column(
        children: [
          ProfileMenuWidget(
            leading: Icons.email_outlined,
            title: email == null ? 'Link Email Account' : emailDisplay!,
            trailing: true,
            callback: () {
              if (email != null) return;
              Get.toNamed(VertifyRoutes.vertify, arguments: {
                'form': VertifyForm.email,
                'callbackEmail': (String email) {
                  Get.to(
                    () => UpdatePasswordScreen(callback: (password) {
                      context.read<LinkAccountWithCredentialBloc>().add(LinkEmailEvent(email, password));
                    }),
                  );
                },
                'fieldValidator': emailValidator,
              });
            },
          ),
          ProfileMenuWidget(
            leading: LineAwesomeIcons.google,
            title: google == null ? 'Link Google Account' : googleDisplay!,
            trailing: true,
            callback: () {
              if (google != null) return;
              context.read<LinkAccountWithCredentialBloc>().add(const LinkGoogleEvent());
            },
          ),
          ProfileMenuWidget(
            leading: Icons.phone_android,
            title: phone == null ? 'Link Phone' : phoneDisplay!,
            trailing: true,
            callback: () {
              if (phone != null) return;
              Get.toNamed(VertifyRoutes.vertify, arguments: {
                'form': VertifyForm.phone,
                'callbackPhone': (PhoneAuthCredential credential) {
                  context.read<LinkAccountWithCredentialBloc>().add(LinkPhoneEvent(credential));
                },
                'fieldValidator': phoneValidator,
              });
            },
          ),
        ],
      ),
    );
  }
}
