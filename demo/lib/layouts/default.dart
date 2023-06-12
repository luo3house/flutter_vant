import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class DemoLayout extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return VanConfig(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F5),
        appBar: VanNavBar(title: title ?? "Flutter Vant UI"),
        body: SafeArea(child: child),
      ),
    );
  }
}
