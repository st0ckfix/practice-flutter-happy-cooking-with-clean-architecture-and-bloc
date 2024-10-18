import 'dart:io';
import 'package:dartz/dartz.dart';

abstract class UpdateImageRepository {
  Future<Either<String, String>> updateImage(File file);
}