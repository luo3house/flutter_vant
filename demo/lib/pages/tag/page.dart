import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class TagPage extends StatelessWidget {
  final Uri location;
  const TagPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      const VanCellGroup(children: [
        VanCell(
            title: "primary", value: Tag(child: "Tag", type: TagType.primary)),
        VanCell(
            title: "success", value: Tag(child: "Tag", type: TagType.success)),
        VanCell(
            title: "danger", value: Tag(child: "Tag", type: TagType.danger)),
        VanCell(
            title: "warning", value: Tag(child: "Tag", type: TagType.warning)),
      ]),

      //
      const DocTitle("Style"),
      VanCellGroup(children: [
        const VanCell(
            title: "Plain",
            value: Tag(child: "Tag", type: TagType.primary, plain: true)),
        const VanCell(
            title: "Rounded",
            value: Tag(child: "Tag", type: TagType.primary, round: true)),
        VanCell(
            title: "Icon",
            value: Tag(
              child: "Tag",
              type: TagType.primary,
              icon: VanIcons.cross,
              // ignore: avoid_print
              onIconTap: () => print("icon tap"),
            )),
      ]),

      //
      const DocTitle("Size"),
      const VanCellGroup(children: [
        VanCell(
            title: "small (Default)",
            value: Tag(child: "Tag", size: TagSize.small)),
        VanCell(
            title: "medium", value: Tag(child: "Tag", size: TagSize.medium)),
        VanCell(title: "large", value: Tag(child: "Tag", size: TagSize.large)),
      ]),

      //
      const DocTitle("Colors"),
      const VanCellGroup(children: [
        VanCell(
            title: "Background Color",
            value: Tag(child: "Tag", color: Color(0xFF7232dd))),
        VanCell(
            title: "Text Color",
            value: Tag(
                child: "Tag",
                color: Color(0xFFffe1e1),
                textColor: Color(0xFFad0000))),
        VanCell(
            title: "Plain",
            value: Tag(child: "Tag", plain: true, color: Color(0xFF7232dd))),
      ]),
    ]);
  }
}
