import 'package:demo/pages/actionsheet/page.dart';
import 'package:demo/pages/badge/page.dart';
import 'package:demo/pages/calendar/page.dart';
import 'package:demo/pages/cascader/page.dart';
import 'package:demo/pages/cell/page.dart';
import 'package:demo/pages/checkbox/page.dart';
import 'package:demo/pages/date_picker/page.dart';
import 'package:demo/pages/dialog/page.dart';
import 'package:demo/pages/divider/page.dart';
import 'package:demo/pages/form/page.dart';
import 'package:demo/pages/grid/page.dart';
import 'package:demo/pages/index_bar/page.dart';
import 'package:demo/pages/input/page.dart';
import 'package:demo/pages/icon/page.dart';
import 'package:demo/pages/layout/page.dart';
import 'package:demo/pages/navbar/page.dart';
import 'package:demo/pages/otp_input/page.dart';
import 'package:demo/pages/picker/page.dart';
import 'package:demo/pages/popup/page.dart';
import 'package:demo/pages/pull_to_refresh/page.dart';
import 'package:demo/pages/radio/page.dart';
import 'package:demo/pages/rate/page.dart';
import 'package:demo/pages/slider/page.dart';
import 'package:demo/pages/swipe/page.dart';
import 'package:demo/pages/swipe_cell/page.dart';
import 'package:demo/pages/switch/page.dart';
import 'package:demo/pages/tab/page.dart';
import 'package:demo/pages/tabbar/page.dart';
import 'package:demo/pages/tag/page.dart';
import 'package:demo/pages/time_picker/page.dart';
import 'package:demo/pages/toast/page.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:go_router/go_router.dart';
import 'package:demo/layouts/default.dart';
import 'package:demo/pages/button/page.dart';
import 'package:demo/pages/index/page.dart';

typedef LocationBuilder = Widget Function(Uri location);

GoRouterPageBuilder withTransition(LocationBuilder builder) {
  return (BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: Builder(builder: (context) {
      return builder(Uri.parse(state.location));
    }));
  };
}

LocationBuilder withScaffold(LocationBuilder builder) {
  return (location) {
    return Builder(builder: (context) {
      final theme = VanConfig.ofTheme(context);
      return Scaffold(
        backgroundColor: theme.background,
        appBar: const NavBar(title: "Flutter Vant UI"),
        // scaffold overrides default textstyle & icon theme, should reassign
        body: DemoLayout(location: location, child: builder(location)),
      );
    });
  };
}

final kRoutes = [
  GoRoute(
    path: "/",
    name: "Index",
    pageBuilder: withTransition(withScaffold((uri) => IndexPage(uri))),
  ),
  GoRoute(
    path: "/button",
    name: "Button",
    pageBuilder: withTransition(withScaffold((uri) => ButtonPage(uri))),
  ),
  GoRoute(
    path: "/icon",
    name: "Icon",
    pageBuilder: withTransition(withScaffold((uri) => IconPage(uri))),
  ),
  GoRoute(
    path: "/cell",
    name: "Cell",
    pageBuilder: withTransition(withScaffold((uri) => CellPage(uri))),
  ),
  GoRoute(
    path: "/layout",
    name: "Layout",
    pageBuilder: withTransition(withScaffold((uri) => LayoutPage(uri))),
  ),
  GoRoute(
    path: "/toast",
    name: "Toast",
    pageBuilder: withTransition(withScaffold((uri) => ToastPage(uri))),
  ),
  GoRoute(
    path: "/popup",
    name: "Popup",
    pageBuilder: withTransition(withScaffold((uri) => PopupPage(uri))),
  ),
  GoRoute(
    path: "/calendar",
    name: "Calendar",
    pageBuilder: withTransition(withScaffold((uri) => CalendarPage(uri))),
  ),
  GoRoute(
    path: "/tab",
    name: "Tab",
    pageBuilder: withTransition(withScaffold((uri) => TabPage(uri))),
  ),
  GoRoute(
    path: "/swipe",
    name: "Swipe",
    pageBuilder: withTransition(withScaffold((uri) => SwipePage(uri))),
  ),
  GoRoute(
    path: "/cascader",
    name: "Cascader",
    pageBuilder: withTransition(withScaffold((uri) => CascaderPage(uri))),
  ),
  GoRoute(
    path: "/checkbox",
    name: "Checkbox",
    pageBuilder: withTransition(withScaffold((uri) => CheckboxPage(uri))),
  ),
  GoRoute(
    path: "/picker",
    name: "Picker",
    pageBuilder: withTransition(withScaffold((uri) => PickerPage(uri))),
  ),
  GoRoute(
    path: "/radio",
    name: "Radio",
    pageBuilder: withTransition(withScaffold((uri) => RadioPage(uri))),
  ),
  GoRoute(
    path: "/rate",
    name: "Rate",
    pageBuilder: withTransition(withScaffold((uri) => RatePage(uri))),
  ),
  GoRoute(
    path: "/slider",
    name: "Slider",
    pageBuilder: withTransition(withScaffold((uri) => SliderPage(uri))),
  ),
  GoRoute(
    path: "/input",
    name: "Input",
    pageBuilder: withTransition(withScaffold((uri) => InputPage(uri))),
  ),
  GoRoute(
    path: "/switch",
    name: "Switch",
    pageBuilder: withTransition(withScaffold((uri) => SwitchPage(uri))),
  ),
  GoRoute(
    path: "/form",
    name: "Form",
    pageBuilder: withTransition(withScaffold((uri) => FormPage(uri))),
  ),
  GoRoute(
    path: "/actionsheet",
    name: "ActionSheet",
    pageBuilder: withTransition(withScaffold((uri) => ActionSheetPage(uri))),
  ),
  GoRoute(
    path: "/dialog",
    name: "Dialog",
    pageBuilder: withTransition(withScaffold((uri) => DialogPage(uri))),
  ),
  GoRoute(
    path: "/pull_to_refresh",
    name: "PullToRefresh",
    pageBuilder: withTransition(withScaffold((uri) => PullToRefreshPage(uri))),
  ),
  GoRoute(
    path: "/swipe_cell",
    name: "SwipeCell",
    pageBuilder: withTransition(withScaffold((uri) => SwipeCellPage(uri))),
  ),
  GoRoute(
    path: "/badge",
    name: "Badge",
    pageBuilder: withTransition(withScaffold((uri) => BadgePage(uri))),
  ),
  GoRoute(
    path: "/divider",
    name: "Divider",
    pageBuilder: withTransition(withScaffold((uri) => DividerPage(uri))),
  ),
  GoRoute(
    path: "/tag",
    name: "Tag",
    pageBuilder: withTransition(withScaffold((uri) => TagPage(uri))),
  ),
  GoRoute(
    path: "/grid",
    name: "Grid",
    pageBuilder: withTransition(withScaffold((uri) => GridPage(uri))),
  ),
  GoRoute(
    path: "/navbar",
    name: "NavBar",
    pageBuilder: withTransition(withScaffold((uri) => NavBarPage(uri))),
  ),
  GoRoute(
    path: "/tabbar",
    name: "TabBar",
    pageBuilder: withTransition(withScaffold((uri) => TabBarPage(uri))),
  ),
  GoRoute(
    path: "/date_picker",
    name: "DatePicker",
    pageBuilder: withTransition(withScaffold((uri) => DatePickerPage(uri))),
  ),
  GoRoute(
    path: "/time_picker",
    name: "TimePicker",
    pageBuilder: withTransition(withScaffold((uri) => TimePickerPage(uri))),
  ),
  GoRoute(
    path: "/index_bar",
    name: "IndexBar",
    pageBuilder: withTransition(withScaffold((uri) => IndexBarPage(uri))),
  ),
  GoRoute(
    path: "/otp_input",
    name: "OTPInput",
    pageBuilder: withTransition(withScaffold((uri) => OTPInputPage(uri))),
  ),
];

final kFullRoutes = <RouteBase>[
  ShellRoute(
    builder: (context, state, child) => DemoLayout(
      location: Uri.parse(state.location),
      title: state.name,
      child: child,
    ),
    routes: kRoutes,
  ),
];
