import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/update_username/update_username_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/username/display_username_widget.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/username/edit_username_wdiget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../config/theme/size.dart';
import '../../../../../core/utils/function.dart';
import '../../pages/profile_page.dart';

class UsernameWidget extends StatefulWidget {
  const UsernameWidget({
    super.key,
  });

  @override
  State<UsernameWidget> createState() => _UsernameWidgetState();
}

class _UsernameWidgetState extends State<UsernameWidget> {
  bool isEditing = false;
  final TextEditingController textEditingController = TextEditingController(text: user.displayName ?? (user.isAnonymous ? 'Anonymous' : 'USER'));
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUsernameBloc, UpdateUsernameState>(
      listener: (context, state) {
        if (state is UpdateUsernameLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
          if (state is! UpdateUsernameInitial) {
            setState(() => isEditing = false);
            onToast(state.failedReason ?? 'Update Successful', () {});
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: formHeight),
        child: isEditing
            ? EditUsernameWdiget(
                textEditingController: textEditingController,
                focusNode: focusNode,
                callback: () {
                  setState(() {
                    textEditingController.text = user.displayName!;
                    focusNode.unfocus();
                    isEditing = false;
                  });
                },
              )
            : DisplayUsernameWidget(
                display: textEditingController.text,
                callback: () {
                  setState(() {
                    focusNode.requestFocus();
                    isEditing = true;
                  });
                },
              ),
      ),
    );
  }
}
