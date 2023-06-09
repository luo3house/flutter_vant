import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class TabPage extends StatelessWidget {
  final Uri location;
  const TabPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      const Tabs(active: "A", children: [
        Tab("A", child: Text("Tab A")),
        Tab("B", child: Text("Tab B")),
        Tab("C", child: Text("Tab C")),
        Tab("D", child: Text("Tab D")),
        Tab("E", child: Text("Tab E")),
        Tab("F", child: Text("Tab F")),
        Tab("G", child: Text("Tab G")),
        Tab("H", child: Text("Tab H")),
        Tab("I", child: Text("Tab I")),
        Tab("J", child: Text("Tab J")),
        Tab("K", child: Text("Tab K")),
        Tab("L", child: Text("Tab L")),
      ]),
      const DocTitle("Navigation"),
      Builder(builder: (context) {
        final scroller = ScrollController();
        final index = ValueNotifier(0);
        return Column(children: [
          ValueListenableBuilder(
            valueListenable: index,
            builder: (_, index, __) {
              return Tabs(
                active: index,
                onChange: (e) => scroller.animateTo(
                  e.index * 150.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                ),
                children: const [
                  Tab("A"),
                  Tab("B"),
                  Tab("C"),
                  Tab("D"),
                  Tab("E"),
                  Tab("F"),
                ],
              );
            },
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (e) {
              index.value = (e.metrics.pixels / 150.0).floor();
              return false;
            },
            child: Container(
              color: const Color(0xFFFFFFFF),
              height: 80,
              child: ListView(
                controller: scroller,
                itemExtent: 150,
                children: const [
                  Text("Tab Content A"),
                  Text("Tab Content B"),
                  Text("Tab Content C"),
                  Text("Tab Content D"),
                  Text("Tab Content E"),
                  Text("Tab Content F"),
                ],
              ),
            ),
          ),
        ]);
      }),
    ]);
  }
}
