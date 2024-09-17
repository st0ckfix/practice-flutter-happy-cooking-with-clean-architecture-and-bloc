import 'package:dartz/dartz.dart';

abstract class EmailVertifyRepository {
  Future<Either<String, String>> smsVertify({String? email});
}