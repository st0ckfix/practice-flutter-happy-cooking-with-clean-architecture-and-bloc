import 'package:dartz/dartz.dart';

import '../../../../core/error/firebase_auth_error.dart';
import '../../../../core/resource/firebase_authentication.dart';
import '../../../../main.dart';

class LogoutFirebase extends AuthenticateFirebase<void, void> {
  @override
  Future<Either<String, void>> execute(void params) async {
    try {
      await auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(getErrorMessage(e.toString()));
    }
  }
}