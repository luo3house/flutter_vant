import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;

// @DocsId("actionsheet")
// DocsWidget("ActionSheet 动作面板")

class ActionSheetPage extends StatelessWidget {
  final Uri location;
  const ActionSheetPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return WithModel<_State>(_State(), (model) {
      return Stack(
        children: [
          ListView(children: [
            const DocTitle("基本用法"),
            Cell(
              title: "基本用法",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..actions = [
                    const ActionSheetItem("选项 1"),
                    const ActionSheetItem("选项 2"),
                    const ActionSheetItem("选项 3"),
                  ]
                  ..onSelect =
                      (item) => ToastStatic.show(context, message: item.name);
              },
            ),
            Cell(
              title: "展示取消按钮",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..actions = [
                    const ActionSheetItem("选项 1"),
                    const ActionSheetItem("选项 2"),
                  ]
                  ..cancelText = "取消"
                  ..onCancel = () {
                    ToastStatic.show(context, message: "Cancel");
                  };
              },
            ),
            Cell(
              title: "展示描述信息",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..description = "描述信息"
                  ..cancelText = "取消"
                  ..actions = [
                    const ActionSheetItem("选项 1"),
                    const ActionSheetItem("选项 2"),
                  ];
              },
            ),

            //
            const DocTitle("自定义选项"),
            Cell(
              title: "自定义选项",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..description = "描述信息"
                  ..actions = [
                    ActionSheetItem(
                      "option1",
                      child: TailTypo().text_color(Colors.red).Text("选项 1"),
                    ),
                    const ActionSheetItem(
                      "option2",
                      disabled: true,
                      child: Text("禁用选项"),
                    ),
                  ];
              },
            ),
          ]),
          ActionSheet(
            show: model.value.show,
            actions: model.value.actions,
            description: model.value.description,
            cancelText: model.value.cancelText,
            closeOnClickAction: model.value.closeOnClickAction,
            onClose: model.value.onClose,
            onCancel: model.value.onCancel,
            onSelect: model.value.onSelect,
          ),
        ],
      );
    });
  }
}

class _State {
  bool? show;
  List<ActionSheetItem>? actions;
  String? description;
  String? cancelText;
  bool? closeOnClickAction;
  Function()? onClose;
  Function()? onCancel;
  Function(ActionSheetItem item)? onSelect;
  clone() {
    return _State()
      ..show = show
      ..actions = actions
      ..description = description
      ..cancelText = cancelText
      ..closeOnClickAction = closeOnClickAction
      ..onClose = onClose
      ..onCancel = onCancel
      ..onSelect = onSelect;
  }
}
