import 'dart:convert';

import 'package:demo/widgets/with_value.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class FormPage extends StatelessWidget {
  final Uri location;
  FormPage(this.location, {super.key});

  final formKey = GlobalKey<VanFormState>();
  final timePickerShow = ValueNotifier(false);
  final timePicker = ValueNotifier(<int>[]);

  @override
  Widget build(BuildContext context) {
    return VanForm(
      initialValue: const {
        "username": "flutter vantui authors",
        "rate": 4.0,
        "slider": 82.0,
      },
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CellGroup(children: [
          // Input
          const VanField(
            label: "Username",
            name: "username",
            child: Input(hint: "Username"),
          ),
          const VanField(
            label: "Password",
            name: "password",
            child: Input(
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
                child: Checkbox(label: "Check 1", shape: BoxShape.rectangle),
              ),
              SizedBox(width: 8),
              VanFormItem(
                name: "checkbox2",
                child: Checkbox(label: "Check 2", shape: BoxShape.rectangle),
              ),
            ]),
          ),

          // Radio
          VanField(
            label: "Radios",
            name: 'radio',
            child: RadioGroup(
              child: Row(children: const [
                Radio(label: "Radio 1", name: "radio1"),
                SizedBox(width: 8),
                Radio(label: "Radio 2", name: "radio2"),
              ]),
            ),
          ),

          // Rate
          const VanField(label: "Rate", name: 'rate', child: Rate()),

          // Slider
          const VanField(
              label: "Slider", name: 'slider', child: Slider(step: 1)),

          // TimePicker
          VanFormItem<List<int>>(
            name: "time_picker",
            builder: (model) {
              return VanField(
                label: "TimePicker",
                clickable: true,
                child: Text(model.value?.toString() ?? '选择时间'),
                onTap: () {
                  late PopupDisposeFn disposePopup;
                  disposePopup = PopupStatic.show(
                    context,
                    round: true,
                    position: PopupPosition.bottom,
                    child: WithModel(model.value, (tmp) {
                      return TimePicker(
                        value: tmp.value,
                        onChange: (v) => tmp.value = v,
                        onCancel: (_) => disposePopup(),
                        onConfirm: (v) {
                          disposePopup();
                          model.setValue(v ?? const []);
                        },
                      );
                    }),
                  );
                },
              );
            },
          ),

          // Custom
          VanField(
            label: "Custom",
            child: VanFormItem(
              builder: (model) {
                return Wrap(spacing: 5, runSpacing: 5, children: [
                  Button(
                    size: ButtonSize.small,
                    onTap: () => model.form?.setFieldValues({}),
                    text: "Reset form values",
                  ),
                  Button(
                    size: ButtonSize.small,
                    text: "Reset to initial",
                    onTap: () => model.form?.resetToInitial(),
                  ),
                ]);
              },
            ),
          ),

          // Submit
          VanFormItem(
            builder: (model) => Button(
              type: ButtonType.primary,
              block: true,
              text: "提交",
              onTap: () {
                final rsp = model.form!.validate();
                if (rsp.errors.isEmpty == true) {
                  ToastStatic.show(context, message: jsonEncode(rsp.values));
                } else {
                  ToastStatic.show(context, message: rsp.errors.join("\n"));
                }
              },
            ),
          )
        ]),
      ]),
    );
  }
}
