import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/resource/firebase_authentication.dart';
import 'package:happy_cooking/main.dart';

class UpdatePasswordFirebase extends AuthenticateFirebase<void, ({String newPassword})> {
  UpdatePasswordFirebase();

  @override
  Future<Either<String, void>> execute(({String newPassword})? params) async {
    try {
      await auth.currentUser!.updatePassword(params!.newPassword);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
