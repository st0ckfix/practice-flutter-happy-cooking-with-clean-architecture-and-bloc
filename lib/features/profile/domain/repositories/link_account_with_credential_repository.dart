import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LinkAccountWithCredentialRepository {
  Future<Either<String, void>> linkAccountWithCredential(AuthCredential credential);
}