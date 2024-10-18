import 'package:dartz/dartz.dart';

abstract class LoginAsGuestRepository {
  Future<Either<String, void>> loginAsGuest();
}
