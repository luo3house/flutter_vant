import 'package:demo/widgets/with_value.dart';
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
        VanGrid(
          columnNum: 4,
          children: [
            GridItem(
              text: "顶部弹出",
              icon: VanIcons.arrow_up,
              clickable: true,
              onTap: () => setState(() {
                reset();
                position = VanPopupPosition.top;
                constraint = const BoxConstraints.tightFor(height: 100);
                show = true;
              }),
            ),
            GridItem(
              text: "底部弹出",
              icon: VanIcons.arrow_down,
              clickable: true,
              onTap: () => setState(() {
                reset();
                position = VanPopupPosition.bottom;
                constraint = const BoxConstraints.tightFor(height: 100);
                show = true;
              }),
            ),
            GridItem(
              text: "左侧弹出",
              icon: VanIcons.arrow_left,
              clickable: true,
              onTap: () => setState(() {
                reset();
                position = VanPopupPosition.left;
                constraint = const BoxConstraints.tightFor(width: 100);
                show = true;
              }),
            ),
            GridItem(
              text: "右侧弹出",
              icon: VanIcons.arrow,
              clickable: true,
              onTap: () => setState(() {
                reset();
                position = VanPopupPosition.right;
                constraint = const BoxConstraints.tightFor(width: 100);
                show = true;
              }),
            ),
          ],
        ),
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
              constraint = const BoxConstraints.tightFor(height: 100);
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
              child = WithModel(true, (model) {
                final height = model.value ? 200.0 : 400.0;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Text("高度: $height"),
                      VanSwitch(
                        size: 18,
                        value: model.value,
                        onChange: (v) => model.value = v,
                      ),
                    ]),
                    Container(height: height),
                  ],
                );
              });
              show = true;
            }),
          ),
          VanCell(
            title: "内容溢出",
            clickable: true,
            onTap: () => setState(() {
              reset();
              position = VanPopupPosition.bottom;
              constraint = const BoxConstraints.tightFor(height: 500);
              child = ListView(
                itemExtent: 16,
                children: List.generate(100, (i) => Text("$i")),
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
