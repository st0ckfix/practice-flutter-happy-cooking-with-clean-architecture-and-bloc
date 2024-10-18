import 'package:dartz/dartz.dart';

abstract class SignupWithEmailRepository {
  Future<Either<String, void>> signupWithEmail(String email, String password, String username);
}