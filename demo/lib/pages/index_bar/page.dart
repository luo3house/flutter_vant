import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class IndexBarPage extends StatelessWidget {
  final Uri location;
  const IndexBarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    final alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    return Tabs(expands: true, active: "generic", children: [
      Tab(
        "generic",
        bgColor: const Color(0x00000000),
        child: IndexBar(
          children: List.of(
            alphabet.map((anchorName) {
              return [
                IndexBarAnchor(anchorName),
                VanCell(title: "Text $anchorName", clickable: true),
                VanCell(title: "Text $anchorName", clickable: true),
                VanCell(title: "Text $anchorName", clickable: true),
              ];
            }).expand((el) => el),
          ),
        ),
      ),
      Tab(
        "custom",
        bgColor: const Color(0x00000000),
        child: IndexBar(
          children: List.of(
            alphabet.map((anchorName) {
              return [
                IndexBarAnchor(anchorName, child: Text("#$anchorName")),
                VanCell(title: "Text $anchorName", clickable: true),
                VanCell(title: "Text $anchorName", clickable: true),
                VanCell(title: "Text $anchorName", clickable: true),
              ];
            }).expand((el) => el),
          ),
        ),
      ),
    ]);
  }
}
