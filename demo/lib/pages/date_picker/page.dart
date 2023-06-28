import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class DatePickerPage extends StatelessWidget {
  final Uri location;
  const DatePickerPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel([DateTime.now().year, DateTime.now().month], (model) {
        return Column(children: [
          Text("${model.value}"),
          VanDatePicker(
            value: model.value,
            onChange: (value) => model.value = value,
          ),
        ]);
      }),

      //
      const DocTitle("Minimum & Maximum"),
      WithModel(const <int>[], (model) {
        return VanDatePicker(
          value: model.value,
          onChange: (value) => model.value = value,
          minDate: DateTime.now().subMonths(1),
          maxDate: DateTime.now().addMonths(1),
        );
      }),

      //
      const DocTitle("Columns"),
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

      //
      const DocTitle("Formatter"),
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

      //
    ]);
  }
}
