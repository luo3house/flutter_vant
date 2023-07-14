import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';

class DocTitle extends StatelessWidget {
  final String title;
  const DocTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    return TailBox().my(16).px(16).Container(
          child: TailTypo().text_color(theme.textColor2).Text(title),
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
