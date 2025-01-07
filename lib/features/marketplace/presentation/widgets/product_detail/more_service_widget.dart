import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

class MoreServiceWidget extends StatelessWidget {
  const MoreServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const TitleWidget('Service'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            minVerticalPadding: 0,
            horizontalTitleGap: 8,
            minLeadingWidth: 20,
            leading: const Icon(Icons.card_membership),
            title: const Text(
              'Membership Card',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IntrinsicWidth(
              child: InkWellTextWidget(
                'Register',
                onClick: () {},
              ),
            ),
          ),
          const Divider(height: 1, thickness: 2),
          ListTile(
            minVerticalPadding: 0,
            horizontalTitleGap: 8,
            minLeadingWidth: 20,
            leading: const Icon(Icons.payment),
            title: const Text(
              'Paylater',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IntrinsicWidth(
              child: InkWellTextWidget(
                'Register',
                onClick: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
