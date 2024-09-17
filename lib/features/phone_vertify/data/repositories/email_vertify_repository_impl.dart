import 'package:dartz/dartz.dart';

import '../../domain/repositories/email_vertify_repository.dart';
import '../datasources/email_vertify_firebase.dart';

class EmailVertifyRepositoryImpl extends EmailVertifyRepository {
  final EmailVertifyFirebase _emailVertifyFirebase;
  EmailVertifyRepositoryImpl(this._emailVertifyFirebase);
  @override
  Future<Either<String, String>> smsVertify({String? email}) {
    return _emailVertifyFirebase.emailVertify(email!);
  }
}
