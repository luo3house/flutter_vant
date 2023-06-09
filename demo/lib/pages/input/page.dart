import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class InputPage extends StatelessWidget {
  final Uri location;
  const InputPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel("", (model) {
        return VanInput(
          onChange: print,
          hint: "Multi Line Available",
          value: model.value,
          autoFocus: true,
        );
      }),

      //
      const DocTitle("Keyboard Type"),
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Plain Text",
          keyboardType: TextInputType.text,
        );
      }),
      const SizedBox(height: 10),
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Phone",
          keyboardType: TextInputType.phone,
        );
      }),
      const SizedBox(height: 10),
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Integer",
          keyboardType: TextInputType.number,
        );
      }),
      const SizedBox(height: 10),
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Decimal",
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        );
      }),
      const SizedBox(height: 10),
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Password",
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        );
      }),

      //
      const DocTitle("Disabled"),
      const VanInput(
        value: "Input Disabled",
        disabled: true,
      ),

      const DocTitle("Max Length"),
      WithModel("", (model) {
        return VanInput(
          value: model.value,
          hint: "Max Length 6",
          maxLength: 6,
        );
      }),
    ]);
  }
}
