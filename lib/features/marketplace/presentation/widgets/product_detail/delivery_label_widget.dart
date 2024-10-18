import 'package:flutter/material.dart';

class DeliveryLabelWidget extends StatelessWidget {
  const DeliveryLabelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      title: Row(
        children: [Icon(Icons.delivery_dining), Text('Can Delivery Today')],
      ),
      subtitle: Text('Discount Up To 70% With Membership'),
    );
  }
}
