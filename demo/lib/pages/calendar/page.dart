import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/child.dart';
import 'package:demo/widgets/watch_model.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

// @DocsId("calendar")
// @DocsWidget("Calendar 日历")

class CalendarPage extends StatefulWidget {
  final Uri location;
  const CalendarPage(this.location, {super.key});

  @override
  State<StatefulWidget> createState() {
    return CalendarPageState();
  }
}

class CalendarPageState extends State<CalendarPage> {
  final singleShow = ValueNotifier(false);
  final singleValues = ValueNotifier(<DateTime>[]);

  final multipleShow = ValueNotifier(false);
  final multipleValues = ValueNotifier(<DateTime>[]);

  final rangeShow = ValueNotifier(false);
  final rangeValues = ValueNotifier(<DateTime>[]);

  final minmaxShow = ValueNotifier(false);
  final minmaxValues = ValueNotifier(<DateTime>[]);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, con) {
      final height = con.maxHeight * .8;

      return ListView(children: [
        const DocTitle("基本用法"),

        NilChild(
          // @DocsDemo("选择单个日期")
          Calendar(
            value: DateTime.now(),
            onChange: (days) => {days[0]},
          ),
          // @DocsDemo
        ),
        NilChild(
          // @DocsDemo("选择多个日期")
          Calendar(
            type: CalendarType.multiple,
            value: [DateTime.now()],
            onChange: (days) => {},
          ),
          // @DocsDemo
        ),
        NilChild(
          // @DocsDemo("选择日期区间")
          Calendar(
            type: CalendarType.range,
            value: [DateTime.now(), DateTime.now().addDays(1)],
            onChange: (fromTo) => {fromTo[0], fromTo[1]},
          ),
          // @DocsDemo
        ),
        NilChild(
          // @DocsDemo("选择日期区间")
          Calendar(
            minDate: DateTime(2010, 1, 1),
            maxDate: DateTime(2010, 2, 1),
          ),
          // @DocsDemo
        ),

        CellGroup(children: [
          Cell(
            clickable: true,
            onTap: () => singleShow.value = true,
            title: "选择单个日期",
            arrow: true,
            value: WatchModel(singleValues, (model) {
              final dates = model.value;
              return Text(dates.isEmpty ? '' : dates.first.format("y/M/d"));
            }),
          ),
          WatchModel(
            singleShow,
            (singleShow) => Popup(
              show: singleShow.value,
              onAfterClose: () => singleShow.value = false,
              round: true,
              constraints: BoxConstraints.tightFor(height: height),
              position: PopupPosition.bottom,
              child: WatchModel(singleValues, (model) {
                return Calendar(
                  expands: true,
                  value: model.value,
                  onCancel: (_) => singleShow.value = false,
                  onConfirm: (value) {
                    singleShow.value = false;
                    singleValues.value = value ?? const [];
                  },
                );
              }),
            ),
          ),
          Cell(
            clickable: true,
            onTap: () => multipleShow.value = true,
            title: "选择多个日期",
            arrow: true,
            value: WatchModel(multipleValues, (model) {
              final dates = model.value;
              return Text(dates.isEmpty ? '' : '已选 ${dates.length} 个日期');
            }),
          ),
          WatchModel(
            multipleShow,
            (multipleShow) => Popup(
              show: multipleShow.value,
              onAfterClose: () => multipleShow.value = false,
              round: true,
              constraints: BoxConstraints.tightFor(height: height),
              position: PopupPosition.bottom,
              child: WatchModel(multipleValues, (model) {
                return Calendar(
                  expands: true,
                  value: model.value,
                  type: CalendarType.multiple,
                  onCancel: (_) => multipleShow.value = false,
                  onConfirm: (value) {
                    multipleShow.value = false;
                    multipleValues.value = value ?? const [];
                  },
                );
              }),
            ),
          ),
          Cell(
            clickable: true,
            onTap: () => rangeShow.value = true,
            title: "选择日期区间",
            arrow: true,
            value: WatchModel(rangeValues, (model) {
              final dates = model.value;
              return Text(dates.length != 2
                  ? ''
                  : '${dates.first.format('M/d')} - ${dates.last.format('M/d')}');
            }),
          ),
          WatchModel(
            rangeShow,
            (rangeShow) => Popup(
              show: rangeShow.value,
              onAfterClose: () => rangeShow.value = false,
              round: true,
              constraints: BoxConstraints.tightFor(height: height),
              position: PopupPosition.bottom,
              child: WatchModel(rangeValues, (model) {
                return Calendar(
                  expands: true,
                  value: model.value,
                  type: CalendarType.range,
                  onCancel: (_) => rangeShow.value = false,
                  onConfirm: (value) {
                    rangeShow.value = false;
                    rangeValues.value = value ?? const [];
                  },
                );
              }),
            ),
          ),
        ]),

        const DocTitle("自定义日历"),
        Cell(
          clickable: true,
          onTap: () => minmaxShow.value = true,
          title: "自定义日期范围",
          arrow: true,
          value: WatchModel(minmaxValues, (model) {
            final dates = model.value;
            return Text(dates.isEmpty ? '' : dates.first.format("y/M/d"));
          }),
        ),
        WatchModel(
          minmaxShow,
          (minmaxShow) => Popup(
            show: minmaxShow.value,
            onAfterClose: () => minmaxShow.value = false,
            round: true,
            constraints: BoxConstraints.tightFor(height: height),
            position: PopupPosition.bottom,
            child: WatchModel(minmaxValues, (model) {
              return Calendar(
                minDate: DateTime(2010, 1).startOfMonth,
                maxDate: DateTime(2010, 1).endOfMonth,
                expands: true,
                value: model.value,
                onCancel: (_) => minmaxShow.value = false,
                onConfirm: (value) {
                  minmaxShow.value = false;
                  minmaxValues.value = value ?? const [];
                },
              );
            }),
          ),
        ),

        const DocTitle("平铺展示"),
        // @DocsDemo("平铺展示")
        const CalendarPanel(),
        // @DocsDemo

        const SizedBox(height: 50),
      ]);
    });
  }
}
