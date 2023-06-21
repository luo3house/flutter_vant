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
      const DocTitle("基本用法"),
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

      const DocTitle("步进取整"),
      WithModel(20.0, (model) {
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
      const SizedBox(height: 10),
      WithModel(6.0, (model) {
        return TailBox().px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) => model.value = v,
              min: 0,
              max: 21,
              step: 3,
              value: model.value,
            ),
          );
        });
      }),

      const DocTitle("自定义样式"),
      WithModel(6.0, (model) {
        return TailBox().px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) => model.value = v,
              min: 0,
              max: 21,
              step: 3,
              value: model.value,
              barHeight: 4,
              activeBg: const Color(0xFFDA3231),
            ),
          );
        });
      }),

      //
      const DocTitle("自定义按钮"),
      WithModel(6.0, (model) {
        return TailBox().px(24).as((s) {
          return s.Container(
            child: VanSlider(
              onChangeEnd: (v) => model.value = v,
              min: 0,
              max: 1000,
              step: 1,
              value: model.value,
              drawThumb: (v) => Transform.translate(
                offset: const Offset(-20, 0),
                child: TailBox()
                    .bg(const Color(0xFF1989fa))
                    .rounded_lg()
                    .p(3)
                    .Container(
                      width: 40,
                      height: 20,
                      child: FittedBox(
                        child: TailTypo().text_color(Colors.white).Text("$v"),
                      ),
                    ),
              ),
            ),
          );
        });
      }),
    ]);
  }
}
