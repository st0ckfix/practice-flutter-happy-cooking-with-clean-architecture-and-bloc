import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/core/constants/images/images.dart';
import 'package:happy_cooking/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:happy_cooking/features/profile/presentation/pages/profile_page.dart';
import 'package:happy_cooking/features/profile/presentation/widgets/image/select_bottom_sheet.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../core/utils/function.dart';
import '../common/circle_icon_button.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    super.key,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool isEditing = false;
  String imageUrl = user.photoURL ?? defaultAvatar;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateImageBloc, UpdateImageState>(
      listener: (context, state) {
        if (state is UpdateImageLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
          if (state is UpdateImageSuccessful) {
            imageUrl = state.dataIfNeeded!;
            setState(() => isEditing = false);
            onToast('Update Successful', () {});
          } else if (state is UpdateImageFailed) {
            setState(() => isEditing = false);
            onToast(state.failedReason!, () {});
          }
        }
      },
      child: Stack(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: user.photoURL == null
                  ? Image.asset(
                      defaultAvatar,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 45,
            child: CircleIconButton(
              leading: LineAwesomeIcons.camera_solid,
              circleSize: 35,
              iconSize: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              callback: () {
                showModalBottomSheet(
                  isScrollControlled: false,
                  context: context,
                  builder: (_) {
                    isEditing = true;
                    return SelectBottomSheet(callback: () {
                      isEditing = false;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
