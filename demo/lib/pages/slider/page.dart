import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';

class SliderPage extends StatelessWidget {
  final Uri location;
  const SliderPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel(50.0, (model) {
        return TailBox().px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) {
                VanToastStatic.show(context, message: "Value: $v");
                model.value = v;
              },
              value: model.value,
            ),
          );
        });
      }),
      WithModel(0.0, (model) {
        return TailBox().mt(12).px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) {
                VanToastStatic.show(context, message: "Value: $v");
                model.value = v;
              },
              min: 0,
              max: 100,
              step: 1,
              value: model.value,
            ),
          );
        });
      }),

      //
      const DocTitle("Step"),
      WithModel(6.0, (model) {
        return TailBox().px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) {
                VanToastStatic.show(context, message: "Value: $v");
                model.value = v;
              },
              min: 0,
              max: 21,
              step: 3,
              value: model.value,
            ),
          );
        });
      }),

      //
      const DocTitle("Draw thumb"),
      WithModel(6.0, (model) {
        return TailBox().px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) {
                VanToastStatic.show(context, message: "Value: $v");
                model.value = v;
              },
              min: 0,
              max: 1000,
              step: 1,
              value: model.value,
              drawThumb: (v) => Transform.translate(
                offset: const Offset(-20, 0),
                child: TailBox().border().bg(Colors.white).rounded_lg().as((s) {
                  return s.Container(
                    width: 40,
                    height: 20,
                    child: FittedBox(child: Text("$v")),
                  );
                }),
              ),
            ),
          );
        });
      }),
    ]);
  }
}
