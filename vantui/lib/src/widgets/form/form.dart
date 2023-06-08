import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../utils/nil.dart';
import '../../utils/std.dart';

abstract class VanFormField {
  String? getFormFieldName();
  String? validateFormValue(dynamic v);
}

class SimpleVanFormField extends Tuple2<String, String? Function(dynamic)>
    implements VanFormField {
  SimpleVanFormField(super.item1, super.item2);
  @override
  String getFormFieldName() => item1;
  @override
  String? validateFormValue(dynamic v) => item2.call(v);
}

class FormValidateError extends Tuple2<VanFormField, String> {
  FormValidateError(super.item1, super.item2);
  VanFormField getField() => item1;
  String getMessage() => item2;
  @override
  String toString() => getMessage();
}

class FormValidateResult
    extends Tuple2<List<FormValidateError>, Map<String, dynamic>> {
  const FormValidateResult(super.item1, super.item2);
  List<FormValidateError> get errors => item1;
  Map<String, dynamic> get values => item2;
}

class VanForm extends StatefulWidget {
  static VanFormState? ofn(BuildContext context) {
    return tryCatch(() => Provider.of<VanFormState>(context));
  }

  final Map<String, dynamic> initialValue;
  final Function(Map<String, dynamic> v)? onChange;
  final Widget? child;

  const VanForm({
    this.initialValue = const {},
    this.onChange,
    this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanFormState();
  }
}

class VanFormState extends State<VanForm> {
  var _values = <String, dynamic>{};
  final _fields = <String, VanFormField>{};

  registerField(VanFormField field) {
    final name = field.getFormFieldName();
    if (name == null) return;
    _fields[name] = field;
  }

  unregisterField(VanFormField field) {
    _fields.remove(field.getFormFieldName());
  }

  getFieldValues() {
    return _values;
  }

  setFieldValue(String k, dynamic v) {
    _values[k] = v;
    setState(() {});
    widget.onChange?.call(_values);
  }

  setFieldValues(Map<String, dynamic> vs) {
    _values = vs;
    setState(() {});
    widget.onChange?.call(_values);
  }

  resetToInitial() {
    _values = {}..addAll(widget.initialValue);
    setState(() {});
    widget.onChange?.call(_values);
  }

  FormValidateResult validate() {
    final fails = <FormValidateError>[];
    for (final field in _fields.values) {
      if (field.getFormFieldName() == null) continue;
      final v = _values[field.getFormFieldName()!];
      String? s;
      if ((s = field.validateFormValue(v)) != null) {
        fails.add(FormValidateError(field, s!));
      }
    }
    return FormValidateResult(fails, _values);
  }

  @override
  void dispose() {
    _values.clear();
    _fields.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _values = {}..addAll(widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<VanFormState>.value(
      updateShouldNotify: (previous, current) => true,
      value: this,
      child: widget.child ?? nil,
    );
  }
}
