
import 'package:flutter/material.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/expandable_list_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final listWidget = List<Widget>.from(description
        .split('. ')
        .map(
          (e) => Text('$e.', textAlign: TextAlign.justify),
        )
        .toList())
      ..add(const SizedBox(height: 10));
    return ListTile(
      title: const TitleWidget('Product Description'),
      subtitle: ExpandableListWidget(
        listWidget: listWidget,
        collapsePositions: [0, listWidget.length - 1],
      ),
    );
  }
}
