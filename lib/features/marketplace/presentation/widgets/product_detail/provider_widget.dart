import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              color: Colors.red,
              height: 60,
              width: 60,
            ),
            title: const Text('Provider: SP-AL'),
            subtitle: const Row(
              children: [
                Text('4.5', style: TextStyle(fontSize: 16)),
                SizedBox(width: 5),
                RatingBar.readOnly(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  isHalfAllowed: true,
                  halfFilledIcon: Icons.star_half,
                  size: 16,
                  initialRating: 4.5,
                  maxRating: 5,
                ),
                SizedBox(width: 5),
                Text('(600+ rated)', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          CustomButton(
            isOutlined: false,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 10),
            title: 'All Products',
            onClick: () {},
          ),
        ],
      ),
    );
  }
}
