import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/product_detail/detail_rating_full_widget.dart';

class CustomerRatedHeaderWidget extends StatefulWidget {
  const CustomerRatedHeaderWidget({
    super.key,
  });

  @override
  State<CustomerRatedHeaderWidget> createState() => _CustomerRatedHeaderWidgetState();
}

class _CustomerRatedHeaderWidgetState extends State<CustomerRatedHeaderWidget> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          'Customers Rated',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '4.5',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(width: 5),
                const RatingBar.readOnly(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  isHalfAllowed: true,
                  halfFilledIcon: Icons.star_half,
                  initialRating: 4.5,
                  maxRating: 5,
                  size: 26,
                ),
                const SizedBox(width: 15),
                const Text('45 rated'),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      icon: Icon(isOpen ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined)),
                )
              ],
            ),
            if (isOpen)
              const Align(
                alignment: Alignment.center,
                child: DetailRatingFullWidget(),
              )
          ],
        ),
      ),
    );
  }
}
