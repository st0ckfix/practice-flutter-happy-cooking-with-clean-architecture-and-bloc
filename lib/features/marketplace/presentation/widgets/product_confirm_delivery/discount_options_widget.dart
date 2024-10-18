import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/discount_value_cubit.dart';

class DiscountOptionsWidget extends StatelessWidget {
  const DiscountOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenDiscountCubit, double>(
      builder: (context, state) {
        return ListTile(
          leading: Container(height: 30, width: 30, color: Colors.pinkAccent),
          title: const Text('Discount 50 cents'),
          subtitle: const Text('Use Your 5 HappyToken'),
          trailing: Switch(
            value: state != 0.0,
            onChanged: (value) => context.read<TokenDiscountCubit>().updateValue(value ? 0.5 : 0.0),
          ),
        );
      },
    );
  }
}
