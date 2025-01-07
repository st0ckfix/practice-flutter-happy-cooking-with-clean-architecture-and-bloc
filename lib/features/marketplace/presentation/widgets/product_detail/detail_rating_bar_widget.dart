import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class DetailRatingBarWidget extends StatelessWidget {
  const DetailRatingBarWidget({
    super.key,
    required this.initial,
    required this.max,
    required this.value,
  });

  final double value;
  final double max;
  final double initial;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: RatingBar.readOnly(
            alignment: Alignment.center,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            initialRating: initial,
            maxRating: 5,
            size: 12,
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 20,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbColor: Colors.transparent,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                ),
                child: Slider(
                  value: value,
                  max: max,
                  min: 0,
                  activeColor: const Color.fromARGB(255, 110, 110, 110),
                  inactiveColor: const Color.fromARGB(255, 209, 209, 209),
                  onChanged: (double value) {},
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              value.toInt().toString(),
              textAlign: TextAlign.end,
            ),
          ),
        )
      ],
    );
  }
}
