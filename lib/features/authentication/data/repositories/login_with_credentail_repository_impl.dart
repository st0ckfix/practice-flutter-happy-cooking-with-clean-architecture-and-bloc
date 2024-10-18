import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/features/authentication/data/datasources/login_with_credential_firebase.dart';
import 'package:happy_cooking/features/authentication/domain/repositories/login_with_credential_repository.dart';

class LoginWithCredentailRepositoryImpl extends LoginWithCredentialRepository {
  final LoginWithCredentialFirebase _loginWithCredentialFirebase;
  LoginWithCredentailRepositoryImpl(this._loginWithCredentialFirebase);
  @override
  Future<Either<String, void>> loginWithCredential(AuthCredential authCredential) {
    return _loginWithCredentialFirebase.execute(authCredential);
  }
}
