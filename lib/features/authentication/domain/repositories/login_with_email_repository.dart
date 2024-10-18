import 'package:dartz/dartz.dart';

abstract class LoginWithEmailRepository {
  Future<Either<String, void>> loginWithEmail(String email, String password);
}
