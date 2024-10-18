import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/config/theme/size.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MediaSelectWidget extends StatelessWidget {
  const MediaSelectWidget({
    super.key,
    required this.source,
    required this.iconData,
    required this.title,
    required this.callback,
  });

  final ImageSource source;
  final IconData iconData;
  final String title;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(formHeight),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(.2), width: 2),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton(
          onPressed: () async {
            await ImagePicker().pickImage(source: source).then((value) {
              if (value != null) {
                context.read<UpdateImageBloc>().add(UpdateImageEvent(File(value.path)));
              } else {
                callback();
              }
              Get.back();
            });
          },
          icon: SizedBox(
            height: 80,
            child: Center(
              child: ListTile(
                title: Icon(
                  iconData,
                  color: Theme.of(context).colorScheme.primary,
                  size: 36,
                ),
                subtitle: Align(alignment: Alignment.topCenter, child: Text(title)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
