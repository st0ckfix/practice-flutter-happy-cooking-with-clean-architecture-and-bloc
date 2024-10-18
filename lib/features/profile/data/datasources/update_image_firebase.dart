import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';
import 'package:happy_cooking/core/resource/firebase_authentication.dart';
import 'package:happy_cooking/main.dart';

import '../../presentation/pages/profile_page.dart';

class UpdateImageFirebase extends AuthenticateFirebase<void, ({File file})> {
  UpdateImageFirebase();

  @override
  Future<Either<String, String>> execute(({File file})? params) async {
    final Completer<Either<String, String>> completer = Completer();
    Reference ref = FirebaseStorage.instance.ref().child("${user.uid}/avatar_${DateTime.now()}.jpg");
    try {
      await ref.putFile(params!.file).whenComplete(() async {
        await ref.getDownloadURL().then((downloadURL) async {
          await auth.currentUser!.updatePhotoURL(downloadURL).then((value) {
            completer.complete(Right(downloadURL));
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      completer.complete(Left(getErrorMessage(e.code)));
    } catch (e) {
      completer.complete(Left(getErrorMessage(e.toString())));
    }
    return completer.future;
  }
}
