import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/watch_model.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("picker")
// @DocsWidget("Picker 选择器")

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

  List<List<PickerOption>> get citiesColumns => [
        [
          PickerOption("杭州", "Hangzhou"),
          PickerOption("宁波", "Ningbo"),
          PickerOption("温州", "Wenzhou"),
          PickerOption("绍兴", "Shaoxing"),
          PickerOption("湖州", "Huzhou"),
        ]
      ];

  List<List<PickerOption>> get weekTimesColumns => [
        [
          PickerOption("周一", "Mon"),
          PickerOption("周二", "Tue"),
          PickerOption("周三", "Wed"),
          PickerOption("周四", "Thu"),
          PickerOption("周五", "Fri"),
        ],
        [
          PickerOption("上午", "Morning"),
          PickerOption("下午", "Afternoon"),
          PickerOption("晚上", "Eve"),
        ],
      ];

  List<PickerOption> get cascadeCities => [
        PickerOption("浙江", "Zhejiang", [
          PickerOption("杭州", "Hangzhou", [
            PickerOption("西湖", "Xihu"),
            PickerOption("余杭", "Yuhang"),
          ]),
          PickerOption("温州", "Wenzhou", [
            PickerOption("鹿城", "Lucheng"),
            PickerOption("瓯海", "Ouhai"),
          ]),
        ]),
        PickerOption("福建", "Fujian", [
          PickerOption("福州", "Fuzhou", [
            PickerOption("鼓楼", "Gulou"),
            PickerOption("台江", "Taijiang"),
          ]),
          PickerOption("厦门", "Xiamen", [
            PickerOption("思明", "Siming"),
            PickerOption("海沧", "Haicang"),
          ]),
        ]),
      ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      // @DocsDemo("基本用法")
      Picker(
        // ignore: avoid_print
        onChange: (values) => print(values),
        columns: citiesColumns,
      ),
      // @DocsDemo

      const DocTitle("无限滑动"),
      // @DocsDemo("无限滑动")
      Picker(columns: citiesColumns, loop: true),
      // @DocsDemo

      //
      const DocTitle("搭配弹出层使用"),
      ValueListenableBuilder(
        valueListenable: popupValues,
        builder: (_, values, __) {
          return Cell(
            title: "选择城市: ${values.join('')}",
            clickable: true,
            onTap: () {
              // @DocsDemo("搭配弹出层使用")
              PopupStatic.show(
                context,
                round: true,
                position: PopupPosition.bottom,
                child: WatchModel(popupValues, (model) {
                  return Picker(
                    onCancel: (_) => popupShow.value = false,
                    onConfirm: (_) => popupShow.value = false,
                    columns: citiesColumns,
                    values: model.value,
                    onChange: (values) => popupValues.value = values,
                  );
                }),
              );
              // @DocsDemo
            },
          );
        },
      ),

      const DocTitle("多列选择"),
      // @DocsDemo("多列选择")
      Picker(columns: weekTimesColumns),
      // @DocsDemo

      const DocTitle("级联选择"),
      // @DocsDemo("级联选择")
      Picker(columns: cascadeCities),
      // @DocsDemo
    ]);
  }
}
