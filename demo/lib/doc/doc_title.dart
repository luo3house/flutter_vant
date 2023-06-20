import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

class DocTitle extends StatelessWidget {
  final String title;
  const DocTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return TailBox().my(16).px(16).Container(
          child: TailTypo().text_color(const Color(0xFF666666)).Text(title),
        );
  }
}

class DocPadding extends StatelessWidget {
  final Widget child;
  const DocPadding(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return TailBox().px(16).mb(10).Container(child: child);
  }
}
