import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class RadioPage extends StatelessWidget {
  final Uri location;
  const RadioPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel(false, (model) {
        return VanRadio(
          checked: model.value,
          onChange: (v) => model.value = v,
          label: "Radio",
        );
      }),

      //
      const DocTitle("Typically Group"),
      WithModel<String?>("a", (model) {
        return VanRadioGroup(
          value: model.value,
          onChange: (name) => model.value = name,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              VanRadio(name: "a"),
              SizedBox(height: 10),
              VanRadio(name: "b"),
            ],
          ),
        );
      }),

      //
      const DocTitle("Horizontal"),
      WithModel<String?>("a", (model) {
        return VanRadioGroup(
          value: model.value,
          onChange: (name) => model.value = name,
          child: Row(children: const [
            VanRadio(name: "a"),
            SizedBox(width: 10),
            VanRadio(name: "b"),
          ]),
        );
      }),

      //
    ]);
  }
}
