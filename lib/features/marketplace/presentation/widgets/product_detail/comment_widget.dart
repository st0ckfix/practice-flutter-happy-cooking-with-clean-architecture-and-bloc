import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/comment_modal_bottom_sheet.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.imageLength,
    required this.imageSize,
    required this.imageLimit,
    required this.crossAxisCount,
    required this.axis,
    this.subtitle,
  });

  final int imageLength;
  final double imageSize;
  final int imageLimit;
  final int crossAxisCount;
  final Axis axis;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Row(
            children: [
              RatingBar.readOnly(
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                initialRating: 5,
                maxRating: 5,
                size: 16,
              ),
              SizedBox(width: 10),
              Text('Extremely Satisfied')
            ],
          ),
          subtitle: ExpandableText(
            'My dad smokes a lot\n'
            'My mom cried until her eyes were blurred\n'
            'Your dad was walking around and your mom was calling every house\n'
            'I haven\'t been home for days, I can\'t contact you at all\n'
            'Just a piece of paper "don\'t worry, I\'m going away tonight',
            expandText: 'show more',
            maxLines: 4,
            linkColor: Colors.blue,
            animation: true,
            collapseOnTextTap: true,
            collapseText: 'show less',
          ),
        ),
        if (imageLength > 0)
          IntrinsicHeight(
            child: ListTile(
              title: Container(
                  margin: EdgeInsets.only(bottom: subtitle != null ? 10 : 0),
                  alignment: Alignment.center,
                  height: imageSize,
                  child: GridView.builder(
                    itemCount: imageLimit + 1,
                    scrollDirection: axis,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, childAspectRatio: 1, mainAxisSpacing: 10, crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      if (index == imageLimit) {
                        return Container(
                          height: imageSize,
                          width: imageSize,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.pink),
                          alignment: Alignment.center,
                          child: Text('+${imageLength - imageLimit}'),
                        );
                      }
                      return Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.pink),
                      );
                    },
                  )),
              subtitle: subtitle,
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.thumb_up), label: const Text('29')),
            TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const CommentModalBottomSheet();
                  },
                );
              },
              icon: const Icon(Icons.chat_bubble),
              label: const Text('Comment (2)'),
            ),
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.share), label: const Text('Share')),
          ],
        )
      ],
    );
  }
}
