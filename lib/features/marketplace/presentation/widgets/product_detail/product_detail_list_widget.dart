import 'package:flutter/material.dart';

class ProductDetailListWidget extends StatelessWidget {
  const ProductDetailListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.withOpacity(.2),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Category'),
              ),
              Expanded(
                flex: 2,
                child: Text('Beef > Chuck'),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Brand'),
              ),
              Expanded(
                flex: 2,
                child: Text('SP-AL'),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(.2),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Brand Base-on'),
              ),
              Expanded(
                flex: 2,
                child: Text('Vietnam'),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Made-in'),
              ),
              Expanded(
                flex: 2,
                child: Text('Vietnam'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
