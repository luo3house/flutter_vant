import 'package:demo/doc/doc_title.dart';
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
      const DocTitle("Basic Usage"),
      // @DocsDemo("基本用法")
      WithModel([DateTime.now().year, DateTime.now().month], (model) {
        return Column(children: [
          Text("${model.value}"),
          VanDatePicker(
            value: model.value,
            onChange: (value) => model.value = value,
          ),
        ]);
      }),
      // @DocsDemo

      const DocTitle("Minimum & Maximum"),
      // @DocsDemo("最大值 & 最小值")
      WithModel(const <int>[], (model) {
        return VanDatePicker(
          value: model.value,
          onChange: (value) => model.value = value,
          minDate: DateTime.now().subMonths(1),
          maxDate: DateTime.now().addMonths(1),
        );
      }),
      // @DocsDemo

      const DocTitle("Columns"),
      // @DocsDemo("指定日期列")
      WithModel(const <int>[], (model) {
        return VanDatePicker(
          value: model.value,
          onChange: (value) => model.value = value,
          columnsType: const {
            VanDateColumn.year,
            VanDateColumn.month,
          },
        );
      }),
      // @DocsDemo

      const DocTitle("Formatter"),
      // @DocsDemo("选项格式化")
      WithModel([DateTime.now().year, DateTime.now().month], (model) {
        return VanDatePicker(
          value: model.value,
          onChange: (value) => model.value = value,
          formatter: {
            VanDateColumn.year: (opt) => opt..name = "${opt.value}年",
            VanDateColumn.month: (opt) => opt..name = "${opt.value}月",
            VanDateColumn.day: (opt) => opt..name = "${opt.value}日",
          },
        );
      }),
      // @DocsDemo

      //
    ]);
  }
}
