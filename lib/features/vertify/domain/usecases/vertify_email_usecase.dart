import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/vertify_email_repository.dart';

class VertifyEmailUseCase implements UseCase<Either<String, String>, String> {
  VertifyEmailRepository vertifyEmailRepository;
  VertifyEmailUseCase(this.vertifyEmailRepository);
  @override
  Future<Either<String, String>> call({String? params}) {
    return vertifyEmailRepository.vertifyEmail(email: params!);
  }
}
