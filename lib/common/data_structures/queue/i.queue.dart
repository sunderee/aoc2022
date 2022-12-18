abstract class IQueue<T> {
  int get size;
  bool get isEmpty;
  bool get isNotEmpty;

  void enqueue(T item);
  T? dequeue();
  T? peek();
}
