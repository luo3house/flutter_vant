import 'package:tuple/tuple.dart';

class ModalState<T, A, B, C, D, E> extends Tuple7<bool, T, A?, B?, C?, D?, E?> {
  const ModalState(
    bool show,
    T value, [
    A? a,
    B? b,
    C? c,
    D? d,
    E? e,
  ]) : super(show, value, a, b, c, d, e);

  bool get show => item1;
  T get value => item2;
  A? get a => item3;
  B? get b => item4;
  C? get c => item5;
  D? get d => item6;
  E? get e => item7;

  ModalState<T, A, B, C, D, E> withShow(bool? show) => copyWith(show: show);
  ModalState<T, A, B, C, D, E> withValue(T? value) => copyWith(value: value);
  ModalState<T, A, B, C, D, E> withA(A? a) => copyWith(a: a);
  ModalState<T, A, B, C, D, E> withB(B? b) => copyWith(b: b);
  ModalState<T, A, B, C, D, E> withC(C? c) => copyWith(c: c);
  ModalState<T, A, B, C, D, E> withD(D? d) => copyWith(d: d);
  ModalState<T, A, B, C, D, E> withE(E? e) => copyWith(e: e);

  ModalState<T, A, B, C, D, E> copyWith({
    bool? show,
    T? value,
    A? a,
    B? b,
    C? c,
    D? d,
    E? e,
  }) =>
      ModalState(
        show ?? this.show,
        value ?? this.value,
        a ?? this.a,
        b ?? this.b,
        c ?? this.c,
        d ?? this.d,
        e ?? this.e,
      );
}
