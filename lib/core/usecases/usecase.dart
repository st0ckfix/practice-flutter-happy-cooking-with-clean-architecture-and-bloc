/// Abstract class representing a basic use case.
/// This class should be extended by use cases that may return data, exception, void or null.
abstract class UseCase<Type, T> {
  Future<Type?> call({T? params});
}
