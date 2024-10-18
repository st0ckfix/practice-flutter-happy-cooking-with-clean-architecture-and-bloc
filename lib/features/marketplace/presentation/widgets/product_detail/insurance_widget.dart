import 'package:flutter/material.dart';

class InsuranceWidget extends StatelessWidget {
  const InsuranceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        title: const Text('Shop With Confidence'),
        subtitle: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 10,
              leading: const Icon(Icons.card_membership, size: 20),
              title: const Text(
                'Check on Delivery',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: InkWell(
                onTap: () {},
                child: const Text(
                  'Detail',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Divider(height: 1, thickness: 2),
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 10,
              leading: const Icon(Icons.payment, size: 20),
              title: const Text(
                'Compensate for poor quality products',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: InkWell(
                onTap: () {},
                child: const Text(
                  'Detail',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
