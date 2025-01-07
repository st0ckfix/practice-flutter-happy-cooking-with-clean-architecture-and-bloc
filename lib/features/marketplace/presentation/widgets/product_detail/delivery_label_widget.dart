import 'package:flutter/material.dart';

class DeliveryLabelWidget extends StatelessWidget {
  const DeliveryLabelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      minVerticalPadding: 0,
      horizontalTitleGap: 8,
      minLeadingWidth: 20,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
      leading: Icon(Icons.delivery_dining_sharp),
      title: Text('Can Delivery Today'),
      subtitle: Text('Discount Up To 70% With Membership'),
    );
  }
}
