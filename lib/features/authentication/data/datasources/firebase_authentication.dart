import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_cooking/core/error/firebase_auth_error.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class LoginWithEmailFirebase {
  const LoginWithEmailFirebase();
  Future onLogin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}

class LoginWithGoogleFirebase {
  const LoginWithGoogleFirebase();

  Future onLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return (credential);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}

class LoginAsGuestFirebase {
  const LoginAsGuestFirebase();
  Future onLogin() async {
    try {
      await auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}

class SignupUserFirebase {
  Future onSignup(String email, String password, String username) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => value.user!.updateDisplayName(username));
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}

class LogoutFirebase {
  const LogoutFirebase();
  Future onLogout() async {
    try {
      await auth.signOut();
    } catch (e) {
      log(e.toString());
      return getErrorMessage(e.toString());
    }
  }
}

class ResetpasswordFirebase {
  const ResetpasswordFirebase();
  Future onReset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return getErrorMessage(e.code);
    } catch (e) {
      log(e.toString());
      return e;
    }
  }
}
