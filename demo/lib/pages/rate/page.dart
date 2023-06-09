import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class RatePage extends StatelessWidget {
  final Uri location;
  const RatePage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel(3.0, (model) {
        return VanRate(
          count: 5,
          value: model.value,
          onChange: (v) => model.value = v,
        );
      }),

      //
      const DocTitle("Half"),
      WithModel(3.3, (model) {
        return VanRate(
          count: 5,
          value: model.value,
          allowHalf: true,
          onChange: (v) => model.value = v,
        );
      }),
    ]);
  }
}
