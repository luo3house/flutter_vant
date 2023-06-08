import 'package:flutter/widgets.dart';

abstract class FormItemChild<T> extends Widget {
  const FormItemChild({super.key});

  Function(T v)? get onChange;
  T? get value;

  FormItemChild<T> cloneWithFormItemChild({
    Function(T v)? onChange,
    T? value,
  });
}
