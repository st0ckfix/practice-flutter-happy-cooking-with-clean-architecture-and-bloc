import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/data/models/address_model.dart';

import '../../domain/repositories/address_repository.dart';

class AddressRepositoryImpl extends AddressRepository {
  AddressRepositoryImpl();
  @override
  Future<Either<String, Map<String, AddressModel>>> getAddress() async {
    return fetchListAddress();
  }
}

Future<Either<String, Map<String, AddressModel>>> fetchListAddress() async {
  await Future.delayed(const Duration(seconds: 1));
  try {
    return Right({
      'user-default': AddressModel.defaultAddress(),
      'user-office': AddressModel.officeAddress(),
    });
  } catch (e) {
    return Left(e.toString());
  }
}
