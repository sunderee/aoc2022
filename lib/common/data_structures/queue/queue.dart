import 'package:aoc2022dart/common/data_structures/queue/i.queue.dart';

class Queue<T> implements IQueue<T> {
  final List<T> _storage = [];

  @override
  int get size => _storage.length;

  @override
  bool get isEmpty => _storage.isEmpty;

  @override
  bool get isNotEmpty => _storage.isNotEmpty;

  @override
  void enqueue(T item) {
    _storage.add(item);
  }

  @override
  T? dequeue() => isNotEmpty ? _storage.removeAt(0) : null;

  @override
  T? peek() => isNotEmpty ? _storage.first : null;
}
