import 'package:flutter/material.dart';

class InvoiceDetailsWidget extends StatelessWidget {
  const InvoiceDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: const Text('Invoice'),
      subtitle: const Text('Only issue electronic invoices'),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
