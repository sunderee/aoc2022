abstract class IStack<T> {
  int get size;
  bool get isEmpty;
  bool get isNotEmpty;

  void push(T item);
  T pop();
  T peek();

  List<T> toList();
}
