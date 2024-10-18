import 'package:flutter/material.dart';

class DeliveryLocationWidget extends StatelessWidget {
  const DeliveryLocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 10,
      horizontalTitleGap: 0,
      title: const Text('Delivery Information'),
      subtitle: ListTile(
        onTap: () {},
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 10,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        leading: const Icon(Icons.place),
        title: const Text(
          'Ho Chi Minh city, Tan Phu dist, Phu Trung',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Text(
          'Change',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
