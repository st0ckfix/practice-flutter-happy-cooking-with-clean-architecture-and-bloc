import 'package:dartz/dartz.dart';

import '../../domain/repositories/send_email_reset_password_repository.dart';
import '../datasources/send_email_reset_password_firebase.dart';

class SendEmailResetPasswordRepositoryImpl extends SendEmailResetPasswordRepository {
  final SendEmailResetPasswordFirebase sendEmailResetPasswordFirebase;
  SendEmailResetPasswordRepositoryImpl(this.sendEmailResetPasswordFirebase);
  @override
  Future<Either<String, void>> sendPasswordResetPassword(String email) {
    return sendEmailResetPasswordFirebase.execute(email);
  }
}