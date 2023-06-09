import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

class SwitchPage extends StatelessWidget {
  final Uri location;
  const SwitchPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      WithModel(false, (model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DocTitle("Basic Usage"),
            VanSwitch(
              onChange: (v) => model.value = v,
              value: model.value,
            ),
            const DocTitle("Disabled"),
            VanSwitch(
              value: model.value,
              disabled: true,
            )
          ],
        );
      }),
      const DocTitle("Size"),
      WithModel(true, (model) {
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          size: 20,
        );
      }),
      const DocTitle("Custom Color"),
      WithModel(true, (model) {
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          bgOnColor: const Color(0xFFEE0A24),
        );
      }),
      const DocTitle("Custom Draw Thumb"),
      WithModel(true, (model) {
        return VanSwitch(
          value: model.value,
          onChange: (v) => model.value = v,
          drawThumb: (v) => Center(
            child: TailTypo() //
                .text_color(Colors.grey)
                .Text(v ? "On" : "Off"),
          ),
        );
      }),
    ]);
  }
}
