import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/expandable_list_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/detail_rating_full_widget.dart';

import '../../cubit/review/review_cubit.dart';

class CustomerRatedHeaderWidget extends StatelessWidget {
  const CustomerRatedHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const TitleWidget('Customers Rated'),
      subtitle: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReviewError) {
            return const Center(
              child: Text('Getting Data Error'),
            );
          } else if (state is ReviewData) {
            final listReviews = state.listReviews;
            final ratingAverage = (listReviews?.map((e) => e.reviewValue).reduce((value, element) => value + element) ?? 0) / (listReviews?.length ?? 1);
            return ExpandableListWidget(
              listWidget: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ratingAverage.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('•', style: Theme.of(context).textTheme.titleLarge),
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      initialRating: ratingAverage,
                      maxRating: 5,
                      size: 26,
                    ),
                    Text('•', style: Theme.of(context).textTheme.titleLarge),
                    Text('${listReviews?.length ?? 0} rated'),
                  ],
                ),
                
                DetailRatingFullWidget(listReviews: listReviews),
                const SizedBox(height: 15),
              ],
              collapsePositions: const [0, 2],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
