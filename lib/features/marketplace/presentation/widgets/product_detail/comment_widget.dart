import 'dart:math';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.userId,
    required this.ratingValue,
    required this.date,
    this.imageSize = 100,
    this.axis = Axis.horizontal,
    this.images,
    this.content,
  });
  final String userId;
  final int ratingValue;
  final String date;
  final List<String>? images;
  final Axis axis;
  final double? imageSize;
  final String? content;

  @override
  Widget build(BuildContext context) {
    final listWidget = [
      Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.amber,
            maxRadius: 15,
          ),
          const SizedBox(width: 10),
          Text(userId),
          const Spacer(),
          Text(date),
        ],
      ),
      RatingBar.readOnly(
        filledIcon: Icons.star,
        emptyIcon: Icons.star_border,
        initialRating: ratingValue.toDouble(),
        maxRating: 5,
        size: 16,
      ),
      if (content != null)
        ExpandableText(
          content!,
          expandText: 'show more',
          maxLines: 3,
          linkColor: Colors.blue,
          animation: true,
          collapseOnTextTap: true,
          collapseText: 'show less',
        ),
      if ((images ?? []).isNotEmpty)
        Container(
          alignment: Alignment.center,
          height: imageSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: images!.sublist(0, min(images!.length, 3)).indexed.map(
              (e) {
                if (e.$1 == 2) {
                  return Container(
                    height: imageSize,
                    width: imageSize,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            images![2],
                          ),
                        ),
                        const Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '+${images!.length - 2}',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Image.asset(
                  height: imageSize,
                  width: imageSize,
                  images![e.$1],
                );
              },
            ).toList(),
          ),
        ),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          listWidget.length * 2 - 1,
          (index) => index.isEven ? listWidget[index ~/ 2] : const SizedBox(height: 10),
        ),
      ),
    );
  }
}
