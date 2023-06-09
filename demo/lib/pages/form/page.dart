import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tuple/tuple.dart';

class FormPage extends StatelessWidget {
  final Uri location;
  FormPage(this.location, {super.key});

  final formKey = GlobalKey<VanFormState>();
  final timePickerDialog = ValueNotifier(ShowWithValue(false, <int>[]));

  @override
  Widget build(BuildContext context) {
    return VanForm(
      initialValue: const {
        "username": "flutter vantui authors",
        "rate": 4,
        "slider": 82,
      },
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        VanCellGroup(children: [
          // Input
          const VanField(
            label: "Username",
            name: "username",
            child: VanInput(hint: "Username"),
          ),
          const VanField(
            label: "Password",
            name: "password",
            child: VanInput(
              hint: "Password",
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),

          // Checkbox
          VanField(
            label: "Checkboxs",
            child: Row(children: const [
              VanFormItem(
                name: "checkbox1",
                child: VanCheckbox(label: "Check 1", shape: BoxShape.rectangle),
              ),
              SizedBox(width: 8),
              VanFormItem(
                name: "checkbox2",
                child: VanCheckbox(label: "Check 2", shape: BoxShape.rectangle),
              ),
            ]),
          ),

          // Radio
          VanField(
            label: "Radios",
            name: 'radio',
            child: VanRadioGroup(
              child: Row(children: const [
                VanRadio(label: "Radio 1", name: "radio1"),
                SizedBox(width: 8),
                VanRadio(label: "Radio 2", name: "radio2"),
              ]),
            ),
          ),

          // Rate
          const VanField(label: "Rate", name: 'rate', child: VanRate()),

          // Slider
          const VanField(
              label: "Slider", name: 'slider', child: VanSlider(step: 1)),

          // TimePicker
          VanField(
            label: "TimePicker",
            clickable: true,
            onTap: () => timePickerDialog.value = ShowWithValue(true, []),
            child: VanFormItem<List<int>>(
              name: "time_picker",
              builder: (model) {
                return OverlayTeleport(
                  local: Text(model.value?.toString() ?? '选择时间'),
                  remote: ValueListenableBuilder(
                    valueListenable: timePickerDialog,
                    builder: (_, dialog, __) {
                      return VanPopup(
                        show: dialog.show,
                        onClose: () {
                          timePickerDialog.value = dialog.copyWith(show: false);
                        },
                        round: true,
                        position: VanPopupPosition.bottom,
                        child: TimePicker(
                          value: dialog.value,
                          onCancel: (_) {
                            timePickerDialog.value =
                                dialog.copyWith(show: false);
                          },
                          onConfirm: (value) {
                            model.setValue(value ?? []);
                            timePickerDialog.value =
                                dialog.copyWith(show: false);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Custom
          VanField(
            label: "Custom",
            child: VanFormItem(
              builder: (model) {
                return Row(children: [
                  VanBtn(
                    size: VanBtnSize.small,
                    onTap: () => model.form?.setFieldValues({}),
                    text: "Reset form values",
                  ),
                  const SizedBox(width: 4),
                  VanBtn(
                    size: VanBtnSize.small,
                    text: "Reset to initial",
                    onTap: () => model.form?.resetToInitial(),
                  ),
                ]);
              },
            ),
          ),

          // Submit
          VanFormItem(
            builder: (model) => VanBtn(
              type: VanBtnType.primary,
              block: true,
              text: "提交",
              onTap: () {
                final rsp = model.form!.validate();
                if (rsp.errors.isEmpty == true) {
                  VanToastStatic.show(context, message: jsonEncode(rsp.values));
                } else {
                  VanToastStatic.show(context, message: rsp.errors.join("\n"));
                }
              },
            ),
          )
        ]),
      ]),
    );
  }
}

class ShowWithValue<T> extends Tuple2<bool, T> {
  ShowWithValue(super.item1, super.item2);
  bool get show => item1;
  T get value => item2;
  ShowWithValue<T> copyWith({bool? show, T? value}) =>
      ShowWithValue<T>(show ?? this.show, value ?? this.value);
}
