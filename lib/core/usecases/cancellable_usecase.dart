import 'dart:async';
import 'package:dartz/dartz.dart';

/// Abstract class representing a cancellable use case.
/// This class should be extended by use cases that may need to be cancelled.
abstract class CancellableUseCase<Type, T> {
  /// Method that executes the use case and can be cancelled via [completer].
  ///
  /// [T] can represents the input parameters required to run the use case.
  /// Returns an [Either] with [String] on the left and [Type] on the right side in case of success.
  Future<Either<String, Type>> call(T params, {required CancelableCompleter completer});
}

/// A CancelableCompleter that can be used to cancel asynchronous operations.
class CancelableCompleter<T> {
  final Completer<T> _completer = Completer<T>();
  bool _isCancelled = false;

  /// Completes with a value if not cancelled.
  void complete(T value) {
    if (!_isCancelled) {
      _completer.complete(value);
    }
  }

  /// Completes with an error if not cancelled.
  void completeError(Object error, [StackTrace? stackTrace]) {
    if (!_isCancelled) {
      _completer.completeError(error, stackTrace);
    }
  }

  /// Cancels the operation and sets [_isCancelled] to true.
  void cancel() {
    _isCancelled = true;
  }

  /// Returns the future that will be completed or cancelled.
  Future<T> get future => _completer.future;

  /// Checks if the completer has been cancelled.
  bool get isCancelled => _isCancelled;
}


