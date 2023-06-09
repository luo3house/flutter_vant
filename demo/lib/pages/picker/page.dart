import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class PickerPage extends StatelessWidget {
  final Uri location;
  const PickerPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      SizedBox(
        height: 240,
        child: VanPicker(
          // ignore: avoid_print
          onChange: (values, _) => print(values),
          columns: const [
            [
              NamedValue("A", "A"),
              NamedValue("B", "B"),
              NamedValue("C", "C"),
              NamedValue("D", "D"),
              NamedValue("E", "E"),
              NamedValue("F", "F"),
            ],
            [
              NamedValue("1", "1"),
              NamedValue("2", "2"),
              NamedValue("3", "3"),
              NamedValue("4", "4"),
              NamedValue("5", "5"),
              NamedValue("6", "6"),
            ],
            [
              NamedValue("甲", "甲"),
              NamedValue("乙", "乙"),
              NamedValue("丙", "丙"),
              NamedValue("丁", "丁"),
              NamedValue("戊", "戊"),
              NamedValue("己", "己"),
              NamedValue("庚", "庚"),
              NamedValue("辛", "辛"),
            ],
          ],
        ),
      ),
      const DocTitle("Loop"),
      SizedBox(
        height: 240,
        child: WithModel<dynamic>(const ["C", "5"], (model) {
          return Column(children: [
            Text(model.value.join(",")),
            Expanded(
              child: VanPicker(
                values: model.value,
                loop: true,
                onChange: (vs, _) => model.value = vs,
                columns: const [
                  [
                    NamedValue("A", "A"),
                    NamedValue("B", "B"),
                    NamedValue("C", "C"),
                    NamedValue("D", "D"),
                    NamedValue("E", "E"),
                    NamedValue("F", "F"),
                  ],
                  [
                    NamedValue("1", "1"),
                    NamedValue("2", "2"),
                    NamedValue("3", "3"),
                    NamedValue("4", "4"),
                    NamedValue("5", "5"),
                    NamedValue("6", "6"),
                  ],
                ],
              ),
            )
          ]);
        }),
      ),
    ]);
  }
}
