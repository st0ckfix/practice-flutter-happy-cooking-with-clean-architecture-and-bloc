import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginWithCredentialRepository {
  Future<Either<String, void>> loginWithCredential(AuthCredential authCredential);
}
