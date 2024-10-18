import 'package:dartz/dartz.dart';

/// Control Firebase Authentication, [String] return a error, exception.
abstract class AuthenticateFirebase<T, Params> {
  Future<Either<String, T>> execute(Params ? params);
}
