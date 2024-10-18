import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/resource/firebase_authentication.dart';
import 'package:happy_cooking/main.dart';

class UpdateUsernameFirebase extends AuthenticateFirebase<void, ({String newUsername})> {
  UpdateUsernameFirebase();

  @override
  Future<Either<String, void>> execute(({String newUsername})? params) async {
    try {
      await auth.currentUser!.updateDisplayName(params!.newUsername);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(getErrorMessage(e.code));
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}
