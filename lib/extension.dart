extension NumExtension on num {
  num get pc => this / 100;
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

  List<T> copyWithRemove(T value) {
    final list = toList();
    list.remove(value);
    return list;
  }
}

extension ObjectExtension<T, K> on T? {
  K? to(K? Function(T value) fn) => this == null ? null : fn(this as T);
}

final floatRegExp =
    RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
