import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class DividerPage extends StatelessWidget {
  final Uri location;
  const DividerPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      DocTitle("Basic Usage"),
      VanDivider(),

      //
      DocTitle("With Text"),
      VanDivider(child: Text("Text")),

      //
      DocTitle("Position"),
      VanDivider(
        contentPosition: ContentPosition.left,
        child: Text("Text"),
      ),
      VanDivider(
        contentPosition: ContentPosition.right,
        child: Text("Text"),
      ),

      //
      DocTitle("Custom Style"),
      VanDivider(
        textStyle: TextStyle(color: Color.fromRGBO(25, 137, 250, 1)),
        child: Text("Text"),
      ),
    ]);
  }
}
