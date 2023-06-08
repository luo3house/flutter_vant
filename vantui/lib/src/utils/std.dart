T? tryCatch<T>(T Function() fn, {T Function(Object e)? orElse}) {
  try {
    return fn();
  } catch (e) {
    return orElse?.call(e);
  }
}

extension MapExt<K, V> on Map<K, V> {
  Map<V, K> reverse() {
    return Map.fromEntries(entries.map((entry) {
      return MapEntry(entry.value, entry.key);
    }));
  }
}

/// [min..max]
List<int> range(int min, int max) {
  if (min > max) {
    final mmax = max;
    max = min;
    min = mmax;
  }
  return List.generate(max - min + 1, (index) => min + index);
}
