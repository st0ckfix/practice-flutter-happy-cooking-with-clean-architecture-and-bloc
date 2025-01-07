import 'package:flutter/material.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';

class BottomAppReview extends StatelessWidget {
  const BottomAppReview({super.key, required this.total, required this.save});

  final double total;
  final double save;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total'),
            Text(
              '${(total).toStringAsFixed(2)}\$',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            save == 0.0
                ? const SizedBox.shrink()
                : Text(
                    'Save ${(save).toStringAsFixed(2)}\$',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.green,
                        ),
                  )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: CustomButton(
              isOutlined: false,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.maxFinite,
              fontSize: 16,
              title: 'Order',
              onClick: () {},
            ),
          ),
        ),
      ],
    );
  }
}
