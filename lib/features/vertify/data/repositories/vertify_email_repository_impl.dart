import 'package:dartz/dartz.dart';

import '../../domain/repositories/vertify_email_repository.dart';
import '../datasources/vertify_email_firebase.dart';

class VertifyEmailRepositoryImpl extends VertifyEmailRepository {
  final VertifyEmailFirebase _vertifyEmailFirebase;
  VertifyEmailRepositoryImpl(this._vertifyEmailFirebase);
  @override
  Future<Either<String, String>> vertifyEmail({String? email}) {
    return _vertifyEmailFirebase.emailVertify(email!);
  }
}
