extension IterableExt<T> on Iterable<T> {
  /// This extension method was copied from the `collection` package. You can
  /// check the documentation here: https://pub.dev/documentation/collection.
  Iterable<List<T>> slices(int length) sync* {
    if (length < 1) {
      throw RangeError.range(length, 1, null, 'length');
    }

    var iterator = this.iterator;
    while (iterator.moveNext()) {
      var slice = [iterator.current];
      for (var i = 1; i < length && iterator.moveNext(); i++) {
        slice.add(iterator.current);
      }
      yield slice;
    }
  }
}
