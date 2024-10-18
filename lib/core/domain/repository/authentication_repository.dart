import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RequestGoogleCredentialRepository {
  Future<Either<String, OAuthCredential>> requestGoogleCredential();
}