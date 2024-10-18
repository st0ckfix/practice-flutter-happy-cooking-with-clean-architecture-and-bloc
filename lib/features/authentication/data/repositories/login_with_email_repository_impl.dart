import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/authentication/data/datasources/login_with_email_firebase.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/login_with_email_repository.dart';

class LoginWithEmailRepositoryImpl extends LoginWithEmailRepository {
  final LoginWithEmailFirebase _loginWithEmailFirebase;
  LoginWithEmailRepositoryImpl(this._loginWithEmailFirebase);
  @override
  Future<Either<String, void>> loginWithEmail(String email, String password) async {
    return _loginWithEmailFirebase.execute((email: email, password: password));
  }
}
