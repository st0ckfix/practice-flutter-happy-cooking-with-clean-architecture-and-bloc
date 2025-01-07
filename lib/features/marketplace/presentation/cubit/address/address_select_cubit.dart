import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/address_entity.dart';
import 'package:happy_cooking/features/marketplace/presentation/cubit/address/address_cubit.dart';

class AddressSelectCubit extends Cubit<AddressEntity?> {
  AddressCubit addressCubit;
  StreamSubscription? addressStreamSubcription;
  AddressSelectCubit({required this.addressCubit}) : super(null) {
    addressStreamSubcription ??= addressCubit.stream.listen((event) {
      if (event is AddressData) {
        updateAddress(addressCubit.getDefaultAddress());
      }
    });
  }

  void updateAddress(AddressEntity? addressEntity) {
    if (addressEntity?.addressId == state?.addressId) return;
    emit(addressEntity);
  }
}
