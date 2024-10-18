import 'package:dartz/dartz.dart';

abstract class LogoutRepository {
  Future<Either<String, void>> logout();
}