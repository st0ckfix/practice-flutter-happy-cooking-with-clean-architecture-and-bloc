import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/update_image_repository.dart';

class UpdateImageUseCase implements UseCase<Either<String, void>, File> {
  UpdateImageRepository updateImage;

  UpdateImageUseCase(this.updateImage);

  @override
  Future<Either<String, String>> call({File? params}) {
    return updateImage.updateImage(params!);
  }
}
