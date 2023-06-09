import 'package:flutter/material.dart' show Scrollbar;
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class TimePickerPage extends StatelessWidget {
  final Uri location;
  const TimePickerPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return WithModel(ScrollController(), (scroller) {
      return Scrollbar(
        controller: scroller.value,
        thumbVisibility: true,
        child: ListView(controller: scroller.value, children: [
          const DocTitle("Basic Usage"),
          WithModel(const <int>[12, 0, 0], (model) {
            return Column(children: [
              Text("${model.value}"),
              TimePicker(
                value: model.value,
                onChange: (value) => model.value = value,
              ),
            ]);
          }),

          //
          const DocTitle("Column Type"),
          WithModel(const <int>[12, 0], (model) {
            return TimePicker(
              columnsType: const {
                TimePickerColumn.hour,
                TimePickerColumn.minute
              },
              value: model.value,
              onChange: (value) => model.value = value,
            );
          }),

          //
          const DocTitle("Range"),
          WithModel(const <int>[], (model) {
            return TimePicker(
              columnsType: const {
                TimePickerColumn.hour,
                TimePickerColumn.minute
              },
              minHour: 10,
              maxHour: 20,
              minMinute: 30,
              maxMinute: 40,
              value: model.value,
              onChange: (value) => model.value = value,
            );
          }),

          //
          const DocTitle("Formatter"),
          WithModel(const <int>[], (model) {
            return TimePicker(
              columnsType: const {
                TimePickerColumn.hour,
                TimePickerColumn.minute
              },
              formatter: {
                TimePickerColumn.hour: (option) =>
                    option.copyWith(name: "${option.value}时"),
                TimePickerColumn.minute: (option) =>
                    option.copyWith(name: "${option.value}分"),
                TimePickerColumn.second: (option) =>
                    option.copyWith(name: "${option.value}秒"),
              },
              value: model.value,
              onChange: (value) => model.value = value,
            );
          }),

          //
          const DocTitle("Filter"),
          WithModel(const <int>[], (model) {
            return TimePicker(
              columnsType: const {
                TimePickerColumn.hour,
                TimePickerColumn.minute
              },
              filter: {
                TimePickerColumn.minute: (options) =>
                    List.of(options.where((m) => m.value % 10 == 0)),
              },
              value: model.value,
              onChange: (value) => model.value = value,
            );
          }),

          //
        ]),
      );
    });
  }
}
