typedef LetCallback<T, R> = R Function(T);

extension ScopeFunctionLet<T> on T {
  /// Calls the specified function [block] with `this` value as its argument and
  /// returns its result.
  R let<R>(LetCallback<T, R> block) {
    return block.call(this);
  }
}
