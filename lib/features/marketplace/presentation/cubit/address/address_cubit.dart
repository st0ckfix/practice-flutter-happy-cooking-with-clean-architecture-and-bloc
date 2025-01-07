import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/address_entity.dart';
import '../../../domain/usecases/address_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressUseCase addressUseCase;
  AddressCubit({required this.addressUseCase}) : super(AddressInitial()) {
    fetchListAddress();
  }

  Future<void> fetchListAddress() async {
    emit(const AddressLoading());
    await addressUseCase.call().then(
      (value) {
        value.fold(
          (error) {
            emit(AddressError(error));
          },
          (mapAddress) {
            emit(AddressData(mapAddress));
          },
        );
      },
    );
  }

  void updateListAddress(String id, AddressEntity addressEntity) {
    final updateMap = Map<String, AddressEntity>.from({...state.mapAddress!, id: addressEntity});
    emit(AddressData(updateMap));
  }

  List<String>? getListAddressId() {
    return state.mapAddress?.keys.toList();
  }

  AddressEntity? getAddressByAddressId(String addressId) {
    return state.mapAddress?[addressId];
  }

  AddressEntity? getDefaultAddress() {
    return state.mapAddress?.values.firstWhere((element) => element.addressDefault);
  }
}
