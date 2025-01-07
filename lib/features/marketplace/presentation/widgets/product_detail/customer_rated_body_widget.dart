import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/review/review_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/comment_fragment.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/comment_widget.dart';

class CustomerRatedBodyWidget extends StatelessWidget {
  const CustomerRatedBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ReviewError) {
          return const Center(
            child: Text('Fetching Got Error'),
          );
        } else if (state is ReviewData) {
          final listReviews = state.listReviews;

          if ((listReviews ?? []).isEmpty) {
            return const Center(
              child: Text('No review found'),
            );
          } else {
            return Column(
              children: List<Widget>.generate(
                listReviews!.sublist(0, min(listReviews.length, 2)).length * 2 - 1,
                (index) => index.isEven
                    ? CommentWidget(
                        images: listReviews[index ~/ 2].reviewImages, // Dùng index ~/ 2
                        ratingValue: listReviews[index ~/ 2].reviewValue,
                        content: listReviews[index ~/ 2].reviewContent,
                        imageSize: 100,
                        userId: listReviews[index ~/ 2].userId,
                        date: listReviews[index ~/ 2].getDateLabel,
                        axis: Axis.horizontal,
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(height: 10, thickness: 1),
                      ),
              )..add(
                  Align(
                    alignment: Alignment.center,
                    child: InkWellTextWidget(
                      'See All',
                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                      onClick: () => Get.to(() => const CommentFragment()),
                    ),
                  ),
                ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
