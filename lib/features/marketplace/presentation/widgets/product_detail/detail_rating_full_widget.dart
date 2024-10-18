import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/detail_rating_bar_widget.dart';

class DetailRatingFullWidget extends StatelessWidget {
  const DetailRatingFullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DetailRatingBarWidget(
          initial: 5,
          max: 45,
          value: 37,
        ),
        DetailRatingBarWidget(
          initial: 4,
          max: 45,
          value: 4,
        ),
        DetailRatingBarWidget(
          initial: 3,
          max: 45,
          value: 3,
        ),
        DetailRatingBarWidget(
          initial: 2,
          max: 45,
          value: 1,
        ),
        DetailRatingBarWidget(
          initial: 1,
          max: 45,
          value: 0,
        ),
      ],
    );
  }
}
