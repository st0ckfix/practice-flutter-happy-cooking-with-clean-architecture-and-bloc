import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/marketplace/data/models/address_model.dart';

abstract class AddressRepository<T> {
  Future<Either<String, Map<String,AddressModel>>> getAddress();
}