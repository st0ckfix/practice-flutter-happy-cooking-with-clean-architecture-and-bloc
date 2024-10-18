import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('message');
    return ListTile(
      title: const Text('Johnny Depp • 0125421597'),
      subtitle: const Text('123 Vanue Place, Ho Chi Ming city, Tan Phu dist, Phu Trung'),
      isThreeLine: true,
      leading: const Icon(Icons.place, color: Colors.blue),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    );
  }
}
