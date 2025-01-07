class AddressEntity {
  final String addressId;
  final String addressLabel;
  final String addressPerson;
  final String addressLine1;
  final String? addressLine2;
  final String addressCity;
  final String addressState;
  final bool addressDefault;
  final int? addressZipCode;

  const AddressEntity({
    required this.addressId,
    required this.addressLabel,
    required this.addressPerson,
    required this.addressLine1,
    this.addressLine2,
    required this.addressCity,
    required this.addressState,
    required this.addressDefault,
    this.addressZipCode,
  });

  AddressEntity copyWith({
    String? addressLabel,
    String? addressPerson,
    String? addressLine1,
    String? addressLine2,
    String? addressCity,
    String? addressState,
    bool? addressDefault,
    int? addressZipCode,
  }) =>
      AddressEntity(
        addressId: addressId,
        addressLabel: addressLabel ?? this.addressLabel,
        addressPerson: addressPerson ?? this.addressPerson,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressCity: addressCity ?? this.addressCity,
        addressState: addressState ?? this.addressState,
        addressDefault: addressDefault ?? this.addressDefault,
        addressLine2: addressLine2 ?? this.addressLine2,
        addressZipCode: addressZipCode ?? this.addressZipCode,
      );
}
