import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/firebase_auth_error.dart';
import '../../../../core/utils/extention.dart';

class UpdatePasswordFirebase {
  const UpdatePasswordFirebase();
  Future onUpdate(String newPassword) async {
    log('update password');
    FirebaseAuth.instance.currentUser.let((it) async {
      try {
        await it.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        log(e.code);
        return getErrorMessage(e.code);
      } catch (e) {
        log(e.toString());
        return getErrorMessage(e.toString());
      }
    });
  }
}

class UpdateUsernameFirebase {
  const UpdateUsernameFirebase();
  Future onUpdate(String newUsername) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      await currentUser!.updateDisplayName(newUsername);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}

class UpdateImageFirebase {
  const UpdateImageFirebase();
  Future onUpdate(String newImage) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    try {
      await currentUser!.updatePhotoURL(newImage);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}
