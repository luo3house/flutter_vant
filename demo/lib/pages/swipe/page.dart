import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

class SwipePage extends StatelessWidget {
  final Uri location;
  const SwipePage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      VanSwipe(
        count: 3,
        builder: (index) {
          final bg = <int, Color>{
            0: const Color(0xFF66C6F2),
            1: const Color(0xFF39A9ED),
            2: const Color(0xFF80A1EF),
          }[index];
          final typo = TailTypo().text_color(const Color(0xFFFFFFFF));
          return TailBox().bg(bg).as((styled) {
            return styled.Container(child: Center(child: typo.Text("$index")));
          });
        },
      ),
      VanSwipe(
        count: 3,
        loop: true,
        builder: (index) {
          final bg = <int, Color>{
            0: const Color(0xFF66C6F2),
            1: const Color(0xFF39A9ED),
            2: const Color(0xFF80A1EF),
          }[index];
          final typo = TailTypo().text_color(const Color(0xFFFFFFFF));
          return TailBox().bg(bg).as((styled) {
            return styled.Container(child: Center(child: typo.Text("$index")));
          });
        },
      ),
    ]);
  }
}
