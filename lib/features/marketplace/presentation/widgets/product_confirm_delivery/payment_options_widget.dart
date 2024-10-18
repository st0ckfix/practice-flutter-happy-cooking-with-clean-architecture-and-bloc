import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PaymentOptionsWidget extends StatelessWidget {
  const PaymentOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Row(
          children: [
            const Text('Payment'),
            Expanded(
              child: InkWell(
                onTap: () => Get.to(() => const PaymentOptionFragment()),
                child: const Text(
                  'Change',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            )
          ],
        ),
        subtitle: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(),
          ),
          alignment: Alignment.center,
          child: const Row(
            children: [
              Icon(Icons.payments_outlined),
              SizedBox(width: 10),
              Text('Cash on Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionFragment extends StatelessWidget {
  const PaymentOptionFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
        title: const Text('Payment Options'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
            margin: const EdgeInsets.only(bottom: 60),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.attach_money),
                      title: const Text('Cash on Delivery'),
                      trailing: Radio(
                        value: 0,
                        groupValue: 0,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.wallet),
                          title: const Text('E-Wallet'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.view_quilt_outlined),
                          title: const Text('Viettel Money'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.monochrome_photos_rounded),
                          title: const Text('Momo'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.attach_money),
                          title: const Text('ZaloPay'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.attach_money),
                          title: const Text('VNPAY'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 5, bottom: 15),
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: const Text('Dis 15%'),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: const Text('Dis 10%'),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: const Text('Dis 8%'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.attach_money),
                          title: Text('Visa Debit'),
                        ),
                        ListTile(
                          leading: const Icon(LineAwesomeIcons.cc_mastercard),
                          title: const Text('VIB •• 2514'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                        ListTile(
                          leading: const Icon(LineAwesomeIcons.cc_mastercard),
                          title: const Text('VIB •• 1956'),
                          trailing: Radio(
                            value: 0,
                            groupValue: 0,
                            onChanged: (value) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            isOutlined: true,
                            leading: const Icon(Icons.add),
                            title: 'Add Card',
                            fontColor: Colors.black,
                            onClick: () {},
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: const EdgeInsets.only(left: 15, top: 5, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.holiday_village_sharp),
                                    const SizedBox(width: 5),
                                    Text(['Freeship', 'Dis 10%', 'Dis 2\$', 'Dis 8%'][Random().nextInt(4)]),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: const Icon(LineAwesomeIcons.wallet_solid),
                      title: const Text('ATM (Internet Banking)'),
                      trailing: Radio(
                        value: 0,
                        groupValue: 0,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 5),
                isOutlined: false,
                title: 'Select',
                fontSize: 15,
                onClick: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
