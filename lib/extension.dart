extension NumExtension on num {
  double get pc => toDouble() / 100;
}

extension ListExtension<T> on List<T> {
  List<T> copyWithReplace(int index, T value) {
    final list = toList();
    list[index] = value;
    return list;
  }

  List<T> copyWithAppend(T value) {
    final list = toList();
    list.add(value);
    return list;
  }

  List<T> copyWithRemoveAt(int value) {
    final list = toList();
    list.removeAt(value);
    return list;
  }
}

extension ObjectExtension<T, K> on T? {
  K? to(K? Function(T value) fn) => this == null ? null : fn(this as T);
}
