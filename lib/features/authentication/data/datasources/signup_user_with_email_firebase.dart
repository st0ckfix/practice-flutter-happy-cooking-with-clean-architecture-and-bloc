import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';

import '../../../../core/resource/firebase_authentication.dart';
import '../../../../main.dart';

class SignUpWithEmailFirebase extends AuthenticateFirebase<void, ({String email, String password, String username})> {
  SignUpWithEmailFirebase();
  @override
  Future<Either<String, void>> execute(({String email, String password, String username})? params) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(email: params!.email, password: params.password);
      await result.user!.updateDisplayName(params.username);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      log('sign error: ${e.code}');
      return Left(getErrorMessage(e.code));
    } catch (e) {
      log('sign error 2: ${e.toString()}');
      return Left(getErrorMessage(e.toString()));
    }
  }
}
