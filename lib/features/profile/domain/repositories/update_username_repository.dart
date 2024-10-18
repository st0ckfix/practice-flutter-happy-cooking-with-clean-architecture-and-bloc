import 'package:dartz/dartz.dart';

abstract class UpdateUsernameRepository {
  Future<Either<String, void>> updateUsername(String newUsername);
}
