import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/profile/data/datasources/update_image_firebase.dart';
import 'package:happy_cooking/features/profile/domain/repositories/update_image_repository.dart';

class UpdateImageRepositoryImpl extends UpdateImageRepository {
  final UpdateImageFirebase _updateImageFirebase;
  UpdateImageRepositoryImpl(this._updateImageFirebase);

  @override
  Future<Either<String, String>> updateImage(File file) async {
    return _updateImageFirebase.execute((file: file));
  }
}
