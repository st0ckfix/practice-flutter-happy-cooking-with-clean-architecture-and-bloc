import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/domain/entities/address_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/address_repository.dart';

class AddressUseCase extends UseCase<Either<String, Map<String,AddressEntity>>, void> {
  final AddressRepository addressRepository;
  AddressUseCase({required this.addressRepository});
  
  @override
  Future<Either<String, Map<String,AddressEntity>>> call({void params}) {
    return addressRepository.getAddress();
  }
}
