import 'package:dartz/dartz.dart';

abstract class SendEmailResetPasswordRepository {
  Future<Either<String, void>> sendPasswordResetPassword(String email);
}
