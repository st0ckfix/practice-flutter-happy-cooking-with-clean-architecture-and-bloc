import 'package:flutter/material.dart';

class MoreServiceWidget extends StatelessWidget {
  const MoreServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        title: const Text('Service'),
        subtitle: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 10,
              leading: const Icon(Icons.card_membership, size: 20),
              title: const Text(
                'Membership Card',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: InkWell(
                onTap: () {},
                child: const Text(
                  'Register',
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
                'Paylater',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: InkWell(
                onTap: () {},
                child: const Text(
                  'Register',
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
