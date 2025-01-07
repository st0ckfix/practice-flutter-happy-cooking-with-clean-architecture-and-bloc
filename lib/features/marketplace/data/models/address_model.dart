import 'package:happy_cooking/features/marketplace/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.addressId,
    required super.addressLabel,
    required super.addressPerson,
    required super.addressLine1,
    required super.addressCity,
    required super.addressState,
    required super.addressDefault,
    super.addressLine2,
    super.addressZipCode,
  });

  factory AddressModel.defaultAddress() {
    return AddressModel(
      addressId: 'user-default',
      addressLabel: 'Home',
      addressPerson: 'Walker Buehler',
      addressLine1: '1000 Vin Scully Ave',
      addressCity: 'Los Angeles',
      addressState: 'California',
      addressDefault: true,
    );
  }

  factory AddressModel.officeAddress() {
    return AddressModel(
      addressId: 'user-office',
      addressLabel: 'Office',
      addressPerson: 'Dalton Knecht',
      addressLine1: '1111 S Figueroa St',
      addressCity: 'Los Angeles',
      addressState: 'California',
      addressDefault: false,
    );
  }
}
