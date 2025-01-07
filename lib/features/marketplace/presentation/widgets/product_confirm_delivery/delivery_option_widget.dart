import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/delivery_cost_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/membership_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DeliveryOptionWidget extends StatelessWidget {
  const DeliveryOptionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final membership = context.read<MembershipCubit>().state;
    final deliveryToday = DeliveryOption.today();
    final deliveryLater = DeliveryOption.later();

    return BlocBuilder<DeliveryCostCubit, DeliveryOption>(
      builder: (context, deliveryOption) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TitleWidget('Delivery Option'),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.lightBlue, width: 1),
                color: Colors.blue.withOpacity(.1),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 15),
                    leading: const Icon(LineAwesomeIcons.car_side_solid),
                    title: TitleWidget(deliveryToday.label, magin: EdgeInsets.zero),
                    subtitle: Text('${(deliveryToday.cost - membership.deliveryDiscount).toStringAsFixed(2)}\$', style: Theme.of(context).textTheme.labelMedium),
                    trailing: Radio(
                      value: deliveryToday.cost,
                      groupValue: deliveryOption.cost,
                      onChanged: (value) {
                        context.read<DeliveryCostCubit>().updateDelivery(deliveryToday);
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.only(left: 15),
                    leading: const Icon(LineAwesomeIcons.motorcycle_solid),
                    title: TitleWidget(deliveryLater.label, magin: EdgeInsets.zero),
                    subtitle: Text('${(deliveryLater.cost - membership.deliveryDiscount).toStringAsFixed(2)}\$', style: Theme.of(context).textTheme.labelMedium),
                    trailing: Radio(
                      value: deliveryLater.cost,
                      groupValue: deliveryOption.cost,
                      onChanged: (value) {
                        context.read<DeliveryCostCubit>().updateDelivery(deliveryLater);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
