import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/domain/repository/authentication_repository.dart';
import 'package:happy_cooking/features/authentication/data/datasources/request_google_credential_firebase.dart';

class RequestGoogleCredentialRepositoryImpl extends RequestGoogleCredentialRepository {
  final RequestGoogleCredentialFirebase _requestGoogleCredentialFirebase;
  RequestGoogleCredentialRepositoryImpl(this._requestGoogleCredentialFirebase);
  @override
  Future<Either<String, OAuthCredential>> requestGoogleCredential() async {
    return _requestGoogleCredentialFirebase.execute(null);
  }
}
