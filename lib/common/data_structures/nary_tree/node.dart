class Node<T> {
  final T data;

  Node<T>? parent;
  List<Node<T>> children = [];

  Node({required this.data});

  void setParent(Node<T> parent) {
    parent = parent;
  }

  void addChild(Node<T> child) {
    child.parent = this;
    children.add(child);
  }

  void addChildAt(Node<T> child, int index) {
    child.parent = this;
    children.insert(index, child);
  }

  void addChildren(List<Node<T>> childNodes) {
    for (var child in childNodes) {
      child.parent = this;
    }

    children.addAll(childNodes);
  }

  bool removeChild(Node<T> child) {
    final childIndex = children.indexWhere((item) => item.data == child.data);
    if (childIndex == -1) {
      return false;
    }

    return removeChildAt(childIndex);
  }

  bool removeChildAt(int index) {
    try {
      children.removeAt(index);
      return true;
    } catch (_) {
      return false;
    }
  }

  void removeChildren() {
    children.clear();
  }

  int getNumberOfDescendants() {
    int currentNodeChildrenLength = children.length;
    for (var child in children) {
      currentNodeChildrenLength += child.getNumberOfDescendants();
    }

    return currentNodeChildrenLength;
  }
}
