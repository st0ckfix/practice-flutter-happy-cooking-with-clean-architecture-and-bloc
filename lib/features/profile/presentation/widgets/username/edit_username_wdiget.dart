import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/update_username/update_username_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../common/circle_icon_button.dart';

class EditUsernameWdiget extends StatelessWidget {
  const EditUsernameWdiget({super.key, required this.focusNode, required this.textEditingController, required this.callback});

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            textAlign: TextAlign.end,
            controller: textEditingController,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: const InputDecoration(border: UnderlineInputBorder()),
            focusNode: focusNode,
          ),
        ),
        CircleIconButton(
          leading: LineAwesomeIcons.check_solid,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
          foregroundColor: Theme.of(context).colorScheme.primary,
          circleSize: 35,
          iconSize: 20,
          horizontalPadding: formHeight,
          callback: () {
            context.read<UpdateUsernameBloc>().add(UpdateUsernameEvent(textEditingController.text));
          },
        ),
        CircleIconButton(
          leading: Icons.clear,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
          foregroundColor: Theme.of(context).colorScheme.primary,
          circleSize: 35,
          iconSize: 20,
          callback: () => callback(),
        ),
      ],
    );
  }
}
