import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:happy_cooking/core/common_widget/custom_text_field.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/address_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/address/address_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/address/address_select_cubit.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/inkwell_text_widget.dart';
import 'package:happy_cooking/features/marketplace/presentation/widgets/common/title_widget.dart';

import '../../../../../core/common_widget/custom_button.dart';
import '../common/select_list_widget.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const TitleWidget('Delivery Address'),
              const Spacer(),
              InkWellTextWidget(
                'Change',
                onClick: () => Get.to(() => const DeliveryAddressFragment()),
              ),
            ],
          ),
        ),
        BlocBuilder<AddressSelectCubit, AddressEntity?>(
          builder: (context, address) {
            if (address != null) {
              return ListTile(
                title: Text(address.addressPerson),
                subtitle: Text(
                  '${address.addressLine1}, ${address.addressCity}, ${address.addressState}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                leading: const Icon(Icons.place, color: Colors.blue),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class DeliveryAddressFragment extends StatelessWidget {
  const DeliveryAddressFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();
    final addressSelectCubit = context.read<AddressSelectCubit>();
    final currentAddress = addressSelectCubit.state;
    final listAddress = addressCubit.getListAddressId();
    int currentSelect = listAddress!.indexWhere((element) => element == currentAddress?.addressId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        title: const Text('Address Options'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => Get.to(
                    () => EditDeliveryAddressFragment(
                      addressEntity: addressCubit.getAddressByAddressId(
                        listAddress[currentSelect],
                      )!,
                    ),
                  ),
              child: const TitleWidget('Edit'))
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: SelectListWidget(
              layoutBuilder: (_, index, isSelected) {
                final address = addressCubit.getAddressByAddressId(listAddress[index]);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Icon(
                      Icons.home,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TitleWidget(
                              address!.addressLabel,
                              magin: const EdgeInsets.symmetric(vertical: 5),
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 10),
                            if (address.addressDefault) Text('default', style: TextStyle(fontStyle: FontStyle.italic, color: isSelected ? Colors.white : Colors.black))
                          ],
                        ),
                        Text(
                          address.addressPerson,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .65,
                          child: Text(
                            '${address.addressLine1}, ${address.addressCity}, ${address.addressState}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 9 / 3,
              ),
              itemCount: listAddress.length,
              onSelect: (select, {selectList}) => currentSelect = select,
              selectMode: SelectMode.single,
              margin: const EdgeInsets.all(10),
              addOnCheck: AddOnCheck.trailingRadio,
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
                onClick: () => addressSelectCubit.updateAddress(
                  addressCubit.getAddressByAddressId(
                    listAddress[currentSelect],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditDeliveryAddressFragment extends StatelessWidget {
  const EditDeliveryAddressFragment({
    super.key,
    required this.addressEntity,
  });

  final AddressEntity addressEntity;

  @override
  Widget build(BuildContext context) {
    bool isDefault = addressEntity.addressDefault;
    final title = TextEditingController(text: addressEntity.addressLabel);
    final person = TextEditingController(text: addressEntity.addressPerson);
    final line1 = TextEditingController(text: addressEntity.addressLine1);
    final line2 = TextEditingController(text: addressEntity.addressLine2);
    final city = TextEditingController(text: addressEntity.addressCity);
    final state = TextEditingController(text: addressEntity.addressState);
    final zipcode = TextEditingController(text: addressEntity.addressZipCode?.toString());
    final listWidget = [
      CustomTextField(
        labelText: 'Address Title',
        textEditingController: title,
        validator: ValidationBuilder().required().build(),
      ),
      CustomTextField(
        labelText: 'Address Person',
        textEditingController: person,
        validator: ValidationBuilder().required().build(),
      ),
      CustomTextField(
        labelText: 'Address Line 1',
        textEditingController: line1,
        validator: ValidationBuilder().required().build(),
      ),
      CustomTextField(
        labelText: 'Address Line 2',
        textEditingController: line2,
        validator: null,
      ),
      CustomTextField(
        labelText: 'Address City',
        textEditingController: city,
        validator: ValidationBuilder().required().build(),
      ),
      CustomTextField(
        labelText: 'Address State',
        textEditingController: state,
        validator: ValidationBuilder().required().build(),
      ),
      CustomTextField(
        labelText: 'Address Zipcode',
        textEditingController: zipcode,
        validator: null,
      ),
      StatefulBuilder(builder: (context, state) {
        return CheckboxListTile(
          value: isDefault,
          title: const Text('Set as Default'),
          onChanged: addressEntity.addressDefault
              ? null
              : (value) {
                  state(() {
                    isDefault = !isDefault;
                  });
                },
        );
      })
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
        title: const Text('Edit Address'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 60,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: ListView.separated(
                itemCount: listWidget.length,
                itemBuilder: (context, index) {
                  return listWidget[index];
                },
                separatorBuilder: (context, index) => const SizedBox(height: 15),
              ),
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
                  title: 'Confirm',
                  fontSize: 15,
                  onClick: () {
                    context.read<AddressCubit>().updateListAddress(
                          addressEntity.addressId,
                          addressEntity.copyWith(
                            addressLabel: title.text,
                            addressPerson: person.text,
                            addressLine1: line1.text,
                            addressLine2: line2.text.isNotEmpty ? null : line2.text,
                            addressCity: city.text,
                            addressState: state.text,
                            addressDefault: isDefault,
                          ),
                        );
                    Get.back();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
