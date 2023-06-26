import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/dialog_state.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget {
  final Uri location;
  const CalendarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, con) {
      final height = con.maxHeight * .8;

      return ListView(children: [
        const DocTitle("基本用法"),
        VanCellGroup(children: [
          _Single(height),
          _Multiple(height),
          _Range(height),
        ]),

        //
        const DocTitle("自定义日历"),
        _DateRange(height),

        //
        const DocTitle("平铺展示"),
        const CalendarPanel(),

        const SizedBox(height: 50),
      ]);
    });
  }
}

class _Single extends StatelessWidget {
  final double height;
  const _Single(this.height);
  @override
  Widget build(BuildContext context) {
    return WithModel(const ModalState(false, <DateTime>[]), (model) {
      final state = model.value;
      final dates = state.value;
      return TeleportOverlay(
        local: VanCell(
          clickable: true,
          onTap: () => model.value = state.withShow(true),
          title: "选择单个日期",
          arrow: true,
          value: dates.isEmpty ? '' : dates.first.format("y/M/d"),
        ),
        child: VanPopup(
          constraints: BoxConstraints.tightFor(height: height),
          show: state.show,
          round: true,
          position: VanPopupPosition.bottom,
          onClose: () => model.value = state.withShow(false),
          child: VanCalendar(
            expands: true,
            value: state.value,
            onCancel: (_) => model.value = state.withShow(false),
            onConfirm: (value) => model.value = state.copyWith(
              show: false,
              value: value ?? [],
            ),
          ),
        ),
      );
    });
  }
}

class _Multiple extends StatelessWidget {
  final double height;
  const _Multiple(this.height);
  @override
  Widget build(BuildContext context) {
    return WithModel(const ModalState(false, <DateTime>[]), (model) {
      final state = model.value;
      final dates = state.value;
      return TeleportOverlay(
        local: VanCell(
          clickable: true,
          onTap: () => model.value = state.withShow(true),
          title: "选择多个日期",
          arrow: true,
          value: dates.isEmpty ? '' : '已选 ${dates.length} 个日期',
        ),
        child: VanPopup(
          constraints: BoxConstraints.tightFor(height: height),
          show: state.show,
          round: true,
          position: VanPopupPosition.bottom,
          onClose: () => model.value = state.withShow(false),
          child: VanCalendar(
            expands: true,
            type: CalendarType.multiple,
            value: state.value,
            onCancel: (_) => model.value = state.withShow(false),
            onConfirm: (value) => model.value = state.copyWith(
              show: false,
              value: value ?? [],
            ),
          ),
        ),
      );
    });
  }
}

class _Range extends StatelessWidget {
  final double height;
  const _Range(this.height);
  @override
  Widget build(BuildContext context) {
    return WithModel(const ModalState(false, <DateTime>[]), (model) {
      final state = model.value;
      final dates = state.value;
      return TeleportOverlay(
        local: VanCell(
          clickable: true,
          onTap: () => model.value = state.withShow(true),
          title: "选择日期区间",
          arrow: true,
          value: dates.length != 2
              ? ''
              : '${dates.first.format('M/d')} - ${dates.last.format('M/d')}',
        ),
        child: VanPopup(
          constraints: BoxConstraints.tightFor(height: height),
          show: state.show,
          round: true,
          position: VanPopupPosition.bottom,
          onClose: () => model.value = state.withShow(false),
          child: VanCalendar(
            expands: true,
            type: CalendarType.range,
            value: state.value,
            onCancel: (_) => model.value = state.withShow(false),
            onConfirm: (value) => model.value = state.copyWith(
              show: false,
              value: value ?? [],
            ),
          ),
        ),
      );
    });
  }
}

class _DateRange extends StatelessWidget {
  final double height;
  const _DateRange(this.height);
  @override
  Widget build(BuildContext context) {
    return WithModel(const ModalState(false, <DateTime>[]), (model) {
      final state = model.value;
      final dates = state.value;
      return TeleportOverlay(
        local: VanCell(
          clickable: true,
          onTap: () => model.value = state.withShow(true),
          title: "自定义日期范围",
          arrow: true,
          value: dates.isEmpty ? '' : dates.first.format("y/M/d"),
        ),
        child: VanPopup(
          constraints: BoxConstraints.tightFor(height: height),
          show: state.show,
          round: true,
          position: VanPopupPosition.bottom,
          onClose: () => model.value = state.withShow(false),
          child: VanCalendar(
            minDate: DateTime(2010, 1).startOfMonth,
            maxDate: DateTime(2010, 1).endOfMonth,
            expands: true,
            value: state.value,
            onCancel: (_) => model.value = state.withShow(false),
            onConfirm: (value) => model.value = state.copyWith(
              show: false,
              value: value ?? [],
            ),
          ),
        ),
      );
    });
  }
}
