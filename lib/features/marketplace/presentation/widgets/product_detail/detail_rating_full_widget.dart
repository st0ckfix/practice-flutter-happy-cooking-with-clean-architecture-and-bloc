import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/review_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/detail_rating_bar_widget.dart';

class DetailRatingFullWidget extends StatelessWidget {
  const DetailRatingFullWidget({super.key, required this.listReviews});
  final List<ReviewEntity>? listReviews;
  @override
  Widget build(BuildContext context) {
    int one = 0, two = 0, three = 0, four = 0, five = 0;
    final max = listReviews?.length ?? 0;
    if (max != 0) {
      for (var element in listReviews!) {
        switch (element.reviewValue) {
          case 1:
            one++;
          case 2:
            two++;
          case 3:
            three++;
          case 4:
            four++;
          default:
            five++;
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DetailRatingBarWidget(
          initial: 5,
          max: max.toDouble(),
          value: five.toDouble(),
        ),
        DetailRatingBarWidget(
          initial: 4,
          max: max.toDouble(),
          value: four.toDouble(),
        ),
        DetailRatingBarWidget(
          initial: 3,
          max: max.toDouble(),
          value: three.toDouble(),
        ),
        DetailRatingBarWidget(
          initial: 2,
          max: max.toDouble(),
          value: two.toDouble(),
        ),
        DetailRatingBarWidget(
          initial: 1,
          max: max.toDouble(),
          value: one.toDouble(),
        ),
      ],
    );
  }
}
