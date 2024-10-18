import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/comment_fragment.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/comment_widget.dart';

class CustomerRatedBodyWidget extends StatelessWidget {
  const CustomerRatedBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CommentWidget(
          imageLength: 9,
          imageSize: 50,
          imageLimit: 4,
          subtitle: Text('Johnny Wood'),
          crossAxisCount: 1,
          axis: Axis.horizontal,
        ),
        const CommentWidget(
          imageLength: 0,
          imageSize: 50,
          imageLimit: 5,
          subtitle: Text('Haley Willis'),
          crossAxisCount: 1,
          axis: Axis.horizontal,
        ),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () => Get.to(() => const CommentFragment()),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'See All',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
