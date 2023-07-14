import 'package:flutter/material.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class DemoLayout extends StatefulWidget {
  final Uri location;
  final String? title;
  final Widget child;
  const DemoLayout({
    required this.location,
    required this.child,
    this.title,
    super.key,
  });

  @override
  createState() => DemoLayoutState();
}

class DemoLayoutState extends State<DemoLayout> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return VanConfig(
      theme: isDark ? VanTheme.dark : VanTheme.fallback,
      child: SafeArea(child: widget.child),
    );
  }
}
