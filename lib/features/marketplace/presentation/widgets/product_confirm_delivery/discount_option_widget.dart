import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/token_discount_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/total_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

class DiscountOptionWidget extends StatelessWidget {
  const DiscountOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final membership = context.read<MembershipCubit>().state;

    return BlocSelector<TotalCubit, Total, double>(
      selector: (total) {
        return total.total;
      },
      builder: (context, total) {
        return BlocBuilder<TokenDiscountCubit, int>(
          builder: (context, state) {
            final tokenAllow = min(membership.tokenAllow, total.floor() * 100);
            return ListTile(
              leading: Image.asset(
                'assets/images/token.png',
                color: Colors.yellow.shade700,
                width: 30,
                height: 30,
              ),
              title: TitleWidget('Discount $tokenAllow cents', magin: EdgeInsets.zero),
              subtitle: Text('Use Your $tokenAllow HappyToken', style: Theme.of(context).textTheme.labelMedium),
              trailing: Switch(
                value: state != 0,
                onChanged: (value) => context.read<TokenDiscountCubit>().updateToken(value ? tokenAllow : 0),
              ),
            );
          },
        );
      },
    );
  }
}
