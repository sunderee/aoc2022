import 'package:aoc2022dart/common/data_structures/stack/i.stack.dart';

class Stack<T> implements IStack<T> {
  final List<T> _storage = [];
  int _capacity = -1;

  Stack(int capacity) {
    _capacity = capacity;
  }

  @override
  int get size => _storage.length;

  @override
  bool get isEmpty => _storage.isEmpty;

  @override
  bool get isNotEmpty => _storage.isNotEmpty;

  @override
  void push(T item) {
    if (size == _capacity) {
      throw StackOperationException('Stack has reached the maxiumum capacity.');
    }
    _storage.add(item);
  }

  @override
  T pop() {
    final lastItem = peek();
    _storage.removeLast();
    return lastItem;
  }

  @override
  T peek() {
    try {
      return _storage.last;
    } on StateError catch (_) {
      throw StackOperationException('Cannot pop from an empty stack');
    }
  }

  @override
  List<T> toList() => _storage;
}

class StackOperationException implements Exception {
  final String message;

  StackOperationException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}
