extension Let<T> on T? {
  R? let<R>(R Function(T) block) => this != null ? block(this as T) : null;
}