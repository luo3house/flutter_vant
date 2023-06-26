import 'dart:convert';

import 'package:demo/widgets/dialog_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class FormPage extends StatelessWidget {
  final Uri location;
  FormPage(this.location, {super.key});

  final formKey = GlobalKey<VanFormState>();
  final timePicker = ValueNotifier(const ModalState(false, <int>[]));

  @override
  Widget build(BuildContext context) {
    return VanForm(
      initialValue: const {
        "username": "flutter vantui authors",
        "rate": 4.0,
        "slider": 82.0,
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
            onTap: () => timePicker.value = const ModalState(true, <int>[]),
            child: VanFormItem<List<int>>(
              name: "time_picker",
              builder: (model) {
                return TeleportOverlay(
                  local: Text(model.value?.toString() ?? '选择时间'),
                  child: ValueListenableBuilder(
                    valueListenable: timePicker,
                    builder: (_, dialog, __) {
                      return VanPopup(
                        show: dialog.show,
                        onClose: () {
                          timePicker.value = dialog.copyWith(show: false);
                        },
                        round: true,
                        position: VanPopupPosition.bottom,
                        child: TimePicker(
                          value: dialog.value,
                          onCancel: (_) {
                            timePicker.value = dialog.copyWith(show: false);
                          },
                          onConfirm: (value) {
                            model.setValue(value ?? []);
                            timePicker.value = dialog.copyWith(show: false);
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
                return Wrap(spacing: 5, runSpacing: 5, children: [
                  VanBtn(
                    size: VanBtnSize.small,
                    onTap: () => model.form?.setFieldValues({}),
                    text: "Reset form values",
                  ),
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
