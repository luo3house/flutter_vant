import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';

// @DocsId("dialog")
// @DocsWidget("Dialog 对话框")

class DialogPage extends StatelessWidget {
  final Uri location;
  const DialogPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      Cell(
        title: "基本用法",
        clickable: true,
        onTap: () {
          // @DocsDemo("基本用法")
          DialogStatic.show(
            context,
            title: "标题",
            message: "如果解决方法是丑陋的，那就肯定还有更好的解决方法，只是还没有发现而已。",
          );
          // @DocsDemo
        },
      ),
      Cell(
        title: "无标题",
        clickable: true,
        onTap: () {
          // @DocsDemo("无标题")
          DialogStatic.show(
            context,
            title: "无标题",
            message: "生命远不止连轴转和忙到极限，人类的体验远比这辽阔、丰富得多。",
          );
          // @DocsDemo
        },
      ),
      Cell(
        title: "确定取消按钮",
        clickable: true,
        onTap: () {
          // @DocsDemo("确定取消按钮")
          DialogStatic.show(
            context,
            title: "标题",
            message: "如果解决方法是丑陋的，那就肯定还有更好的解决方法，只是还没有发现而已。",
            action: DialogConfirm(
              onOK: () => ToastStatic.show(context, message: "确定了"),
              onCancel: () => ToastStatic.show(context, message: "取消了"),
              okText: "确定",
              cancelText: "取消",
            ),
          );
          // @DocsDemo
        },
      ),

      //
      const DocTitle("自定义渲染"),
      Cell(
        title: "自定义渲染",
        clickable: true,
        onTap: () {
          // @DocsDemo("自定义渲染")
          DialogStatic.show(
            context,
            title: "标题",
            message: TailBox().p(20).as((s) {
              return s.Container(
                child: Image.network(
                    "https://fastly.jsdelivr.net/npm/@vant/assets/apple-3.jpeg"),
              );
            }),
          );
          // @DocsDemo
        },
      ),

      Cell(
        title: "长内容渲染",
        clickable: true,
        onTap: () {
          // @DocsDemo("长内容渲染")
          DialogStatic.show(
            context,
            title: "标题",
            expands: true,
            message: ListView.builder(
              itemCount: 999,
              itemBuilder: (_, i) => Text("Item $i"),
            ),
            action: DialogConfirm(onOK: () {}, onCancel: () {}),
          );
          // @DocsDemo
        },
      ),
    ]);
  }
}
