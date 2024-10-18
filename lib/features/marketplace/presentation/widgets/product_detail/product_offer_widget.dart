import 'package:flutter/material.dart';

class ProductOfferWidget extends StatelessWidget {
  const ProductOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            color: Colors.redAccent,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const Text(
              'Reputation',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 30,
            color: Colors.blueAccent,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const Text(
              'Quality',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          const Text('Provider: SP-AL')
        ],
      ),
    );
  }
}
