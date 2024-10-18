import 'package:dartz/dartz.dart';

import '../../domain/repositories/logout_repository.dart';
import '../datasources/logout_firebase.dart';

class LogoutRepositoryImpl extends LogoutRepository {
  final LogoutFirebase _logoutFirebase;
  LogoutRepositoryImpl(this._logoutFirebase);
  @override
  Future<Either<String, void>> logout() {
    return _logoutFirebase.execute(null);
  }
}
