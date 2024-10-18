import 'package:dartz/dartz.dart';

abstract class UpdatePasswordRepository {
  Future<Either<String, void>> updatePassword(String newPassword);
}
