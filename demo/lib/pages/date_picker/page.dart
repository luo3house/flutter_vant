import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/child.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("datepicker")
// @DocsWidget("DatePicker 日期选择")

class DatePickerPage extends StatelessWidget {
  final Uri location;
  const DatePickerPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      WithModel([DateTime.now().year, DateTime.now().month], (model) {
        return Column(children: [
          Text("${model.value}"),
          // @DocsDemo("基本用法")
          DatePicker(
            value: model.value,
            onChange: (value) => model.value = value,
          ),
          // @DocsDemo
        ]);
      }),
      const DocTitle("最大值 & 最小值"),
      WithModel(const <int>[], (model) {
        return Child(
          // @DocsDemo("最大值 & 最小值")
          DatePicker(
            value: model.value,
            onChange: (value) => model.value = value,
            minDate: DateTime.now().subMonths(1),
            maxDate: DateTime.now().addMonths(1),
          ),
          // @DocsDemo
        );
      }),
      const DocTitle("指定日期列"),
      WithModel(const <int>[], (model) {
        return Child(
          // @DocsDemo("指定日期列")
          DatePicker(
            value: model.value, // [year, month]
            onChange: (value) => model.value = value,
            columnsType: const {DateColumn.year, DateColumn.month},
          ),
          // @DocsDemo
        );
      }),
      const DocTitle("选项格式化"),
      WithModel(
        [DateTime.now().year, DateTime.now().month],
        (model) {
          return Child(
            // @DocsDemo("选项格式化")
            DatePicker(
              value: model.value,
              onChange: (value) => model.value = value,
              formatter: {
                DateColumn.year: (opt) => opt..name = "${opt.value}年",
                DateColumn.month: (opt) => opt..name = "${opt.value}月",
                DateColumn.day: (opt) => opt..name = "${opt.value}日",
              },
            ),
            // @DocsDemo
          );
        },
      ),
    ]);
  }
}
