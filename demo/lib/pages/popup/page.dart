import 'package:demo/widgets/child.dart';
import 'package:demo/widgets/watch_model.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("popup")
// @DocsWidget("Popup 弹出层")

class PopupPage extends StatefulWidget {
  final Uri location;
  const PopupPage(this.location, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopupPage();
  }
}

class _PopupPage extends State<PopupPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView(children: [
        const DocTitle("Basic Usage"),
        Cell(
          title: "展示弹出层",
          clickable: true,
          // onTap: () => basicShow.value = true,
          onTap: () {
            // @DocsDemo("基本用法")
            PopupStatic.show(
              context,
              padding: const EdgeInsets.all(64),
              child: const Text("内容"),
            );
            // @DocsDemo
          },
        ),

        const DocTitle("弹出位置"),
        Grid(
          columnNum: 4,
          children: [
            GridItem(
              text: "顶部弹出",
              icon: VanIcons.arrow_up,
              clickable: true,
              onTap: () {
                // @DocsDemo("顶部弹出")
                PopupStatic.show(
                  context,
                  position: PopupPosition.top,
                  constraints: const BoxConstraints.tightFor(height: 100),
                );
                // @DocsDemo
              },
            ),
            GridItem(
              text: "底部弹出",
              icon: VanIcons.arrow_down,
              clickable: true,
              onTap: () {
                PopupStatic.show(
                  context,
                  position: PopupPosition.bottom,
                  constraints: const BoxConstraints.tightFor(height: 100),
                );
              },
            ),
            GridItem(
              text: "左侧弹出",
              icon: VanIcons.arrow_left,
              clickable: true,
              onTap: () {
                PopupStatic.show(
                  context,
                  position: PopupPosition.left,
                  constraints: const BoxConstraints.tightFor(width: 100),
                );
              },
            ),
            GridItem(
              text: "右侧弹出",
              icon: VanIcons.arrow,
              clickable: true,
              onTap: () {
                PopupStatic.show(
                  context,
                  position: PopupPosition.right,
                  constraints: const BoxConstraints.tightFor(width: 100),
                );
              },
            ),
          ],
        ),

        //
        const DocTitle("圆角弹窗"),
        CellGroup(children: [
          Cell(
            title: "圆角弹窗 (居中)",
            clickable: true,
            onTap: () {
              // @DocsDemo("圆角弹窗")
              PopupStatic.show(
                context,
                round: true,
                padding: const EdgeInsets.all(64),
                child: const Text("内容"),
              );
              // @DocsDemo
            },
          ),
          Cell(
            title: "圆角弹窗 (底部)",
            clickable: true,
            onTap: () {
              PopupStatic.show(
                context,
                round: true,
                position: PopupPosition.bottom,
                constraints: const BoxConstraints.tightFor(height: 100),
                child: const Center(child: Text("内容")),
              );
            },
          ),
        ]),

        //
        const DocTitle("内容"),
        CellGroup(children: [
          Cell(
            title: "内容自适应",
            clickable: true,
            onTap: () {
              late Function() close;
              close = PopupStatic.show(
                context,
                round: true,
                position: PopupPosition.bottom,
                child: Builder(builder: (_) {
                  var taller = true;
                  return StatefulBuilder(builder: (_, setState) {
                    final double height = taller ? 400 : 200;
                    return SizedBox(
                      height: height,
                      child: Column(children: [
                        const Expanded(child: nil),
                        Button(
                          type: ButtonType.primary,
                          size: ButtonSize.small,
                          text: "Height: $height",
                          onTap: () => setState(() => taller = !taller),
                        ),
                        const SizedBox(height: 20),
                        Button(
                          text: "Close Popup",
                          size: ButtonSize.small,
                          onTap: close,
                        ),
                        const SizedBox(height: 50),
                      ]),
                    );
                  });
                }),
              );
            },
          ),
          Cell(
            title: "内容溢出",
            clickable: true,
            onTap: () {
              PopupStatic.show(
                context,
                round: true,
                position: PopupPosition.bottom,
                constraints: const BoxConstraints.tightFor(height: 400),
                padding: const EdgeInsets.all(20),
                child: ListView(
                  itemExtent: 40,
                  padding: EdgeInsets.zero,
                  children: List.generate(100, (i) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Flutter Vant UI"),
                        Icon(VanIcons.good_job_o),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ]),
      ]),
    ]);
  }
}
