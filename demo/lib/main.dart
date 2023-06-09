import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:go_router/go_router.dart';
import 'package:demo/routes.dart';

void main() {
  runApp(
    WidgetsApp.router(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      routerConfig: GoRouter(routes: kFullRoutes),
      builder: (context, child) {
        return VanConfig(child: SafeArea(child: child!));
      },
    ),
  );
}
