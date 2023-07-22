import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;

// @DocsId("actionsheet")
// @DocsWidget("ActionSheet 动作面板")

class ActionSheetPage extends StatelessWidget {
  final Uri location;
  const ActionSheetPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      Cell(
        title: "基本用法",
        clickable: true,
        onTap: () {
          // @DocsDemo("基本用法")
          ActionSheetStatic.show(context, actions: const [
            ActionSheetItem("选项 1"),
            ActionSheetItem("选项 2"),
            ActionSheetItem("选项 3"),
          ], onSelect: (item) {
            ToastStatic.show(context, message: item.name);
          });
          // @DocsDemo
        },
      ),
      Cell(
        title: "展示取消按钮",
        clickable: true,
        onTap: () {
          // @DocsDemo("展示取消按钮")
          ActionSheetStatic.show(
            context,
            actions: const [
              ActionSheetItem("选项 1"),
              ActionSheetItem("选项 2"),
            ],
            onSelect: (item) {
              ToastStatic.show(context, message: item.name);
            },
            cancelText: "取消",
            onCancel: () {
              ToastStatic.show(context, message: "Cancel");
            },
          );
          // @DocsDemo
        },
      ),
      Cell(
        title: "展示描述信息",
        clickable: true,
        onTap: () {
          // @DocsDemo("展示描述信息")
          ActionSheetStatic.show(
            context,
            description: "描述信息",
            cancelText: "取消",
            actions: [
              const ActionSheetItem("选项 1"),
              const ActionSheetItem("选项 2"),
            ],
          );
          // @DocsDemo
        },
      ),

      //
      const DocTitle("自定义选项"),
      Cell(
        title: "自定义选项",
        clickable: true,
        onTap: () {
          ActionSheetStatic.show(
            context,
            description: "描述信息",
            cancelText: "取消",
            actions: [
              ActionSheetItem(
                "option1",
                child: TailTypo().text_color(Colors.red).Text("选项 1"),
              ),
              const ActionSheetItem(
                "option2",
                disabled: true,
                child: Text("禁用选项"),
              ),
            ],
          );
        },
      ),
    ]);
  }
}
