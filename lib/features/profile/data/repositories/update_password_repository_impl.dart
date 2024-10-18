import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/profile/data/datasources/update_password_firebase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_password_repository.dart';

class UpdatePasswordRepositoryImpl extends UpdatePasswordRepository {
  final UpdatePasswordFirebase _updatePasswordFirebase;
  UpdatePasswordRepositoryImpl(this._updatePasswordFirebase);
  @override
  Future<Either<String, void>> updatePassword(String newPassword) async {
    return _updatePasswordFirebase.execute((newPassword: newPassword));
  }
}
