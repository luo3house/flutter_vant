import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/widgets/form/types.dart';
import 'package:tuple/tuple.dart';
import 'form.dart';

class FormItemBuilderModel<T>
    extends Tuple3<T?, Function(dynamic v), VanFormState?> {
  FormItemBuilderModel(super.item1, super.item2, super.item3);

  T? get value => item1;
  setValue(T v) => item2.call(v);
  VanFormState? get form => item3;
}

class VanFormItem<T> extends StatefulWidget {
  final String? name;
  final Widget Function(FormItemBuilderModel<T> model)? builder;
  final FormItemChild? child;
  final String? Function(T? v)? validate;

  const VanFormItem({
    this.name,
    this.validate,
    this.builder,
    this.child,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanFormItemState<T>();
  }
}

class VanFormItemState<T> extends State<VanFormItem<T>>
    implements VanFormField {
  VanFormState? form;

  @override
  void initState() {
    super.initState();
    assert(widget.child != null || widget.builder != null,
        "either child or builder should be set");
  }

  @override
  String? getFormFieldName() {
    return widget.name;
  }

  @override
  String? validateFormValue(v) {
    return widget.validate?.call(v);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form?.unregisterField(this);
    form = VanForm.ofn(context);
    form?.registerField(this);
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    form?.unregisterField(this);
    form = VanForm.ofn(context);
    form?.registerField(this);
  }

  @override
  void dispose() {
    form?.unregisterField(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = getFormFieldName();

    final T? value = name == null ? null : form?.getFieldValues()[name];
    onChange(dynamic v) {
      (name == null ? null : form?.setFieldValue)?.call(name!, v);
    }

    final builder = widget.builder;
    if (builder != null) {
      return builder(FormItemBuilderModel<T>(value, onChange, form));
    } else {
      return widget.child!.cloneWithFormItemChild(
        value: value,
        onChange: onChange,
      );
    }
  }
}
