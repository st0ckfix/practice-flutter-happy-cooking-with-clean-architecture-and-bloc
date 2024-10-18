import 'package:dartz/dartz.dart';

abstract class VertifyEmailRepository {
  Future<Either<String, String>> vertifyEmail({String? email});
}