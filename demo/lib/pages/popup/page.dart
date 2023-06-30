import 'package:demo/widgets/watch_model.dart';
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
  final basicShow = ValueNotifier(false);

  var pos = PopupPosition.center;
  final posShow = ValueNotifier(false);

  var roundPos = PopupPosition.center;
  final roundShow = ValueNotifier(false);

  final fitContentShow = ValueNotifier(false);
  final listContentShow = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(children: [
        const DocTitle("Basic Usage"),
        VanCell(
          title: "展示弹出层",
          clickable: true,
          onTap: () => basicShow.value = true,
        ),
        Popup(
          show: basicShow,
          padding: const EdgeInsets.all(64),
          child: const Text("内容"),
        ),

        //
        const DocTitle("弹出位置"),
        VanGrid(
          columnNum: 4,
          children: [
            GridItem(
              text: "顶部弹出",
              icon: VanIcons.arrow_up,
              clickable: true,
              onTap: () {
                pos = PopupPosition.top;
                posShow.value = true;
              },
            ),
            GridItem(
              text: "底部弹出",
              icon: VanIcons.arrow_down,
              clickable: true,
              onTap: () {
                pos = PopupPosition.bottom;
                posShow.value = true;
              },
            ),
            GridItem(
              text: "左侧弹出",
              icon: VanIcons.arrow_left,
              clickable: true,
              onTap: () {
                pos = PopupPosition.left;
                posShow.value = true;
              },
            ),
            GridItem(
              text: "右侧弹出",
              icon: VanIcons.arrow,
              clickable: true,
              onTap: () {
                pos = PopupPosition.right;
                posShow.value = true;
              },
            ),
          ],
        ),
        WatchModel(posShow, (model) {
          return Popup(
            show: posShow,
            position: pos,
            constraints: <PopupPosition, BoxConstraints?>{
              PopupPosition.left: const BoxConstraints.tightFor(width: 100),
              PopupPosition.right: const BoxConstraints.tightFor(width: 100),
              PopupPosition.top: const BoxConstraints.tightFor(height: 100),
              PopupPosition.bottom: const BoxConstraints.tightFor(height: 100),
            }[pos],
          );
        }),

        //
        const DocTitle("圆角弹窗"),
        VanCellGroup(children: [
          VanCell(
            title: "圆角弹窗 (居中)",
            clickable: true,
            onTap: () {
              roundPos = PopupPosition.center;
              roundShow.value = true;
            },
          ),
          VanCell(
            title: "圆角弹窗 (底部)",
            clickable: true,
            onTap: () {
              roundPos = PopupPosition.bottom;
              roundShow.value = true;
            },
          ),
        ]),
        WatchModel(roundShow, (model) {
          return Popup(
            show: roundShow,
            round: true,
            position: roundPos,
            child: SizedBox.fromSize(
              size: const Size.square(100),
              child: const Center(child: Text("内容")),
            ),
          );
        }),

        //
        const DocTitle("内容"),
        VanCellGroup(children: [
          VanCell(
            title: "内容自适应",
            clickable: true,
            onTap: () => fitContentShow.value = true,
          ),
          VanCell(
            title: "内容溢出",
            clickable: true,
            onTap: () => listContentShow.value = true,
          ),
        ]),
      ]),
      Popup(
        show: fitContentShow,
        position: PopupPosition.bottom,
        round: true,
        child: WithModel(false, (model) {
          final height = model.value ? 200.0 : 400.0;
          return TweenAnimationBuilder(
            tween: Tween(begin: height, end: height),
            duration: const Duration(milliseconds: 200),
            builder: (_, x, __) {
              return SizedBox(
                height: x,
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("Height: $height"),
                    VanSwitch(
                      value: model.value,
                      onChange: (v) => model.value = v,
                    ),
                  ]),
                ),
              );
            },
          );
        }),
      ),
      Popup(
        show: listContentShow,
        constraints: const BoxConstraints.tightFor(height: 500),
        position: PopupPosition.bottom,
        child: ListView(
          itemExtent: 40,
          children: List.generate(100, (i) => Center(child: Text("$i"))),
        ),
      ),
    ]);
  }
}
