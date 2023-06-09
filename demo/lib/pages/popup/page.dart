import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class PopupPage extends StatefulWidget {
  final Uri location;
  const PopupPage(this.location, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopupPage();
  }
}

class _PopupPage extends State<PopupPage> {
  bool? show;
  bool? overlay;
  VanPopupPosition? position;
  EdgeInsets? padding;
  bool? round;
  bool? closeOnClickOverlay;
  Widget? child;
  BoxConstraints? constraint;

  reset() {
    show = null;
    overlay = null;
    position = null;
    padding = null;
    round = null;
    closeOnClickOverlay = null;
    child = null;
    constraint = null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(children: [
        const DocTitle("Basic Usage"),
        VanCell(
          title: "展示弹出层",
          clickable: true,
          onTap: () => setState(() {
            reset();
            child = const Text("内容");
            padding = const EdgeInsets.all(64);
            show = true;
          }),
        ),
        const DocTitle("Position"),
        VanCellGroup(children: [
          VanCell(
            title: "顶部弹出",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.top;
              constraint = const BoxConstraints(minHeight: 100);
              show = true;
            }),
          ),
          VanCell(
            title: "底部弹出",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.bottom;
              constraint = const BoxConstraints(minHeight: 100);
              show = true;
            }),
          ),
          VanCell(
            title: "左侧弹出",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.left;
              constraint = const BoxConstraints(minWidth: 100);
              show = true;
            }),
          ),
          VanCell(
            title: "右侧弹出",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.right;
              constraint = const BoxConstraints(minWidth: 100);
              show = true;
            }),
          ),
        ]),
        const DocTitle("圆角弹窗"),
        VanCellGroup(children: [
          VanCell(
            title: "圆角弹窗 (居中)",
            clickable: true,
            onTap: () => setState(() {
              reset();
              child = const Text("内容");
              round = true;
              padding = const EdgeInsets.all(64);
              show = true;
            }),
          ),
        ]),
        VanCellGroup(children: [
          VanCell(
            title: "圆角弹窗 (底部)",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.bottom;
              round = true;
              constraint = const BoxConstraints(minHeight: 100);
              show = true;
            }),
          ),
        ]),
        const DocTitle("内容"),
        VanCellGroup(children: [
          VanCell(
            title: "内容自适应",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.bottom;
              child = Column(
                children: List.generate(5, (_) => const Text("-")),
              );
              show = true;
            }),
          ),
          VanCell(
            title: "内容溢出",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.bottom;
              constraint = const BoxConstraints(maxHeight: 500);
              child = ListView(
                itemExtent: 16,
                children: List.generate(5000, (_) => const Text("-")),
              );
              show = true;
            }),
          ),
        ]),
      ]),
      VanPopup(
        show: show,
        overlay: overlay,
        position: position,
        padding: padding,
        round: round,
        closeOnClickOverlay: closeOnClickOverlay,
        constraints: constraint,
        onClose: () => setState(() => show = false),
        child: child,
      )
    ]);
  }
}
