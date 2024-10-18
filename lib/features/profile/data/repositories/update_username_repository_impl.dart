import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/profile/data/datasources/update_username_firebase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_username_repository.dart';

class UpdateUsernameRepositoryImpl extends UpdateUsernameRepository {
  final UpdateUsernameFirebase _updateUsernameFirebase;
  UpdateUsernameRepositoryImpl(this._updateUsernameFirebase);
  @override
  Future<Either<String, void>> updateUsername(String newUsername) async {
    return _updateUsernameFirebase.execute((newUsername: newUsername));
  }
}
