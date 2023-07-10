import 'package:demo/widgets/child.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

// @DocsId("tag")
// @DocsWidget("Tag 标签")

class TagPage extends StatelessWidget {
  final Uri location;
  const TagPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      CellGroup(
        children: List.of(const [
          // @DocsDemo("基本用法")
          Tag(child: "Tag", type: TagType.primary),
          Tag(child: "Tag", type: TagType.success),
          Tag(child: "Tag", type: TagType.danger),
          Tag(child: "Tag", type: TagType.warning),
          // @DocsDemo
        ].map((tag) => Cell(title: tag.type!.toString(), value: tag))),
      ),

      const DocTitle("Style"),
      CellGroup(children: [
        const NilChild([
          // @DocsDemo("朴素样式、形状、图标")
          Tag(child: "Tag", type: TagType.primary, plain: true),
          Tag(child: "Tag", type: TagType.primary, round: true),
          Tag(child: "Tag", type: TagType.primary, icon: VanIcons.cross),
          // @DocsDemo
        ]),
        const Cell(
            title: "Plain",
            value: Tag(child: "Tag", type: TagType.primary, plain: true)),
        const Cell(
            title: "Rounded",
            value: Tag(child: "Tag", type: TagType.primary, round: true)),
        Cell(
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
      CellGroup(
        children: List.of(const [
          // @DocsDemo("大小")
          Tag(child: "Tag", size: TagSize.small),
          Tag(child: "Tag", size: TagSize.medium),
          Tag(child: "Tag", size: TagSize.large),
          // @DocsDemo
        ].map((tag) => Cell(title: tag.size!.toString(), value: tag))),
      ),

      //
      const DocTitle("Colors"),
      const CellGroup(children: [
        NilChild([
          // @DocsDemo("颜色")
          Tag(child: "Tag", color: Color(0xFF7232dd)),
          Tag(
            child: "Tag",
            color: Color(0xFFffe1e1),
            textColor: Color(0xFFad0000),
          ),
          Tag(child: "Tag", plain: true, color: Color(0xFF7232dd)),
          // @DocsDemo
        ]),
        Cell(
          title: "Background Color",
          value: Tag(child: "Tag", color: Color(0xFF7232dd)),
        ),
        Cell(
          title: "Text Color",
          value: Tag(
            child: "Tag",
            color: Color(0xFFffe1e1),
            textColor: Color(0xFFad0000),
          ),
        ),
        Cell(
          title: "Plain",
          value: Tag(child: "Tag", plain: true, color: Color(0xFF7232dd)),
        ),
      ]),
    ]);
  }
}
