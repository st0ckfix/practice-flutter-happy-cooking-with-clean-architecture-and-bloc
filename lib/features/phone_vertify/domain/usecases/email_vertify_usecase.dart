import 'package:dartz/dartz.dart';
import 'package:happy_cooking/features/phone_vertify/domain/repositories/email_vertify_repository.dart';

import '../../../../core/usecases/usecase.dart';

class EmailVertifyUseCase implements UseCase<Either<String, String>, String> {
  EmailVertifyRepository emailVertifyRepository;
  EmailVertifyUseCase(this.emailVertifyRepository);
  @override
  Future<Either<String, String>> call({String? params}) {
    throw emailVertifyRepository.smsVertify(email: params!);
  }
}
