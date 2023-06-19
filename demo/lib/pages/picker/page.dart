import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class PickerPage extends StatefulWidget {
  final Uri location;
  const PickerPage(this.location, {super.key});

  @override
  State<StatefulWidget> createState() {
    return PickerPageState();
  }
}

class PickerPageState extends State<PickerPage> {
  final popupShow = ValueNotifier(false);
  final popupValues = ValueNotifier([]);

  List<List<NamedValue>> get citiesColumns => const [
        [
          NamedValue("杭州", "Hangzhou"),
          NamedValue("宁波", "Ningbo"),
          NamedValue("温州", "Wenzhou"),
          NamedValue("绍兴", "Shaoxing"),
          NamedValue("湖州", "Huzhou"),
        ]
      ];

  List<List<NamedValue>> get weekTimesColumns => const [
        [
          NamedValue("周一", "Mon"),
          NamedValue("周二", "Tue"),
          NamedValue("周三", "Wed"),
          NamedValue("周四", "Thu"),
          NamedValue("周五", "Fri"),
        ],
        [
          NamedValue("上午", "Morning"),
          NamedValue("下午", "Afternoon"),
          NamedValue("晚上", "Eve"),
        ],
      ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      VanPicker(
        // ignore: avoid_print
        onChange: (values, _) => print(values),
        columns: citiesColumns,
      ),

      const DocTitle("搭配弹出层使用"),
      ValueListenableBuilder(
        valueListenable: popupValues,
        builder: (_, values, __) {
          return VanCell(
            title: "选择城市: ${values.join('')}",
            clickable: true,
            onTap: () => popupShow.value = true,
          );
        },
      ),
      TeleportOverlay(
        child: ValueListenableBuilder(
          valueListenable: popupShow,
          builder: (_, show, __) {
            return VanPopup(
              round: true,
              show: show,
              onClose: () => popupShow.value = false,
              position: VanPopupPosition.bottom,
              child: ValueListenableBuilder(
                valueListenable: popupValues,
                builder: (_, values, __) {
                  return VanPicker(
                    onCancel: (_) => popupShow.value = false,
                    onConfirm: (_) => popupShow.value = false,
                    columns: citiesColumns,
                    values: values,
                    onChange: (values, _) => popupValues.value = values,
                  );
                },
              ),
            );
          },
        ),
      ),

      const DocTitle("多列选择"),
      VanPicker(columns: weekTimesColumns),
      // const DocTitle("Loop"),
      // WithModel<dynamic>(const ["C", "5"], (model) {
      //   return Column(children: [
      //     Text(model.value.join(",")),
      //     VanPicker(
      //       values: model.value,
      //       loop: true,
      //       onChange: (vs, _) => model.value = vs,
      //       columns: const [
      //         [
      //           NamedValue("A", "A"),
      //           NamedValue("B", "B"),
      //           NamedValue("C", "C"),
      //           NamedValue("D", "D"),
      //           NamedValue("E", "E"),
      //           NamedValue("F", "F"),
      //         ],
      //         [
      //           NamedValue("1", "1"),
      //           NamedValue("2", "2"),
      //           NamedValue("3", "3"),
      //           NamedValue("4", "4"),
      //           NamedValue("5", "5"),
      //           NamedValue("6", "6"),
      //         ],
      //       ],
      //     ),
      //   ]);
      // }),
    ]);
  }
}
