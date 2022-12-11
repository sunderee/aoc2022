typedef PredicateCallback<T> = bool Function(T);

extension ScopeFunctionTakes<T> on T {
  /// Returns `this` value if it satisfies the given [predicate] or null, if it
  /// doesn't.
  T? takeIf(PredicateCallback<T> predicament) {
    return predicament.call(this) ? this : null;
  }

  /// Returns `this` value if it does not satisfy the given [predicate] or null,
  /// if it does.
  T? takeUnless(PredicateCallback<T> predicament) {
    return predicament.call(this) ? null : this;
  }
}
