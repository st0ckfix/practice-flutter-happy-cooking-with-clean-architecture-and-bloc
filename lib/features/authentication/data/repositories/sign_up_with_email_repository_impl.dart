import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/authentication/data/datasources/signup_user_with_email_firebase.dart';

import '../../domain/repositories/signup_with_email_repository.dart';

class SignUpWithEmailRepositoryImpl extends SignupWithEmailRepository {
  final SignUpWithEmailFirebase _signUpWithEmailFirebase;
  SignUpWithEmailRepositoryImpl(this._signUpWithEmailFirebase);

  @override
  Future<Either<String, void>> signupWithEmail(String email, String password, String username) {
    return _signUpWithEmailFirebase.execute((email: email, password: password, username: username));
  }
}