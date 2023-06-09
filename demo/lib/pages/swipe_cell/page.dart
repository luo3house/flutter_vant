import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

class SwipeCellPage extends StatelessWidget {
  final Uri location;
  const SwipeCellPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      VanSwipeCell(
        left: const VanBtn(
            square: true, text: "Select", type: VanBtnType.primary),
        right: Row(mainAxisSize: MainAxisSize.min, children: const [
          VanBtn(square: true, text: "Delete", type: VanBtnType.danger),
          VanBtn(square: true, text: "Star", type: VanBtnType.primary),
        ]),
        child: const VanCell(title: "Swipe me", value: "Content"),
      ),

      //
      const DocTitle("Click to close"),
      WithModel(GlobalKey<VanSwipeCellState>(), (model) {
        final key = model.value;
        return VanSwipeCell(
          key: key,
          right: Row(mainAxisSize: MainAxisSize.min, children: [
            VanBtn(
              square: true,
              text: "Delete",
              type: VanBtnType.danger,
              onTap: () => key.currentState?.close(),
            ),
            VanBtn(
              square: true,
              text: "Star",
              type: VanBtnType.primary,
              onTap: () => key.currentState?.close(),
            ),
          ]),
          child: const VanCell(title: "Cell", value: "Content"),
        );
      }),

      //
      const DocTitle("Custom child"),
      Container(
        height: 200,
        color: Colors.white,
        child: ListView.builder(
          itemExtent: 40,
          itemCount: 100,
          itemBuilder: (_, index) {
            return WithModel(GlobalKey<VanSwipeCellState>(), (model) {
              final key = model.value;
              return VanSwipeCell(
                key: key,
                right: VanBtn(
                  square: true,
                  text: "Contact #$index",
                  type: VanBtnType.primary,
                  onTap: () => {key.currentState?.close()},
                ),
                child: TailBox().px(10).border(Colors.grey.shade300).as((s) {
                  return s.Container(
                    child: Center(
                      child: Row(children: [
                        const VanIcon(VanIcons.user_circle_o),
                        const SizedBox(width: 10),
                        Text("User #$index"),
                      ]),
                    ),
                  );
                }),
              );
            });
          },
        ),
      ),

      //
    ]);
  }
}
