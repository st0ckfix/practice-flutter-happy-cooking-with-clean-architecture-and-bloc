part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  final Map<String, AddressEntity>? mapAddress;
  final String? error;
  const AddressState({this.mapAddress, this.error});

  @override
  List<Object> get props => [mapAddress ?? {}, error ?? 'Error'];
}

final class AddressInitial extends AddressState {
  AddressInitial() : super(mapAddress: {});
}

final class AddressLoading extends AddressState {
  const AddressLoading() : super();
}

final class AddressData extends AddressState {
  const AddressData(Map<String, AddressEntity> mapAddress) : super(mapAddress: mapAddress);
}

final class AddressError extends AddressState {
  const AddressError(String error) : super(error: error);
}
