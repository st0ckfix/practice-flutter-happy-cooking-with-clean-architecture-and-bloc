import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';

class DiscountOptionsWidget extends StatelessWidget {
  const DiscountOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final membership = context.read<MembershipCubit>().state;
    return BlocBuilder<TokenDiscountCubit, int>(
      builder: (context, state) {
        return ListTile(
          leading: Image.asset(
            'assets/images/token.png',
            color: Colors.yellow.shade700,
            width: 30,
            height: 30,
          ),
          title: Text('Discount ${membership.tokenAllow} cents'),
          subtitle: Text('Use Your ${membership.tokenAllow} HappyToken'),
          trailing: Switch(
            value: state != 0.0,
            onChanged: (value) => context.read<TokenDiscountCubit>().updateDiscountToken(value ? membership.tokenAllow : 0),
          ),
        );
      },
    );
  }
}
