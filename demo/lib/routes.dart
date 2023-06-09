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
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:demo/layouts/default.dart';
import 'package:demo/pages/button/page.dart';
import 'package:demo/pages/index/page.dart';

GoRouterPageBuilder withPage(Widget Function(Uri location) locaitonBuilder) {
  return (BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: Builder(builder: (context) {
      return locaitonBuilder(Uri.parse(state.location));
    }));
  };
}

final kRoutes = [
  GoRoute(
    path: "/",
    name: "Index",
    pageBuilder: withPage((uri) => IndexPage(uri)),
  ),
  GoRoute(
    path: "/button",
    name: "Button",
    pageBuilder: withPage((uri) => ButtonPage(uri)),
  ),
  GoRoute(
    path: "/icon",
    name: "Icon",
    pageBuilder: withPage((uri) => IconPage(uri)),
  ),
  GoRoute(
    path: "/cell",
    name: "Cell",
    pageBuilder: withPage((uri) => CellPage(uri)),
  ),
  GoRoute(
    path: "/layout",
    name: "Layout",
    pageBuilder: withPage((uri) => LayoutPage(uri)),
  ),
  GoRoute(
    path: "/toast",
    name: "Toast",
    pageBuilder: withPage((uri) => ToastPage(uri)),
  ),
  GoRoute(
    path: "/popup",
    name: "Popup",
    pageBuilder: withPage((uri) => PopupPage(uri)),
  ),
  GoRoute(
    path: "/calendar",
    name: "Calendar",
    pageBuilder: withPage((uri) => CalendarPage(uri)),
  ),
  GoRoute(
    path: "/tab",
    name: "Tab",
    pageBuilder: withPage((uri) => TabPage(uri)),
  ),
  GoRoute(
    path: "/swipe",
    name: "Swipe",
    pageBuilder: withPage((uri) => SwipePage(uri)),
  ),
  GoRoute(
    path: "/cascader",
    name: "Cascader",
    pageBuilder: withPage((uri) => CascaderPage(uri)),
  ),
  GoRoute(
    path: "/checkbox",
    name: "Checkbox",
    pageBuilder: withPage((uri) => CheckboxPage(uri)),
  ),
  GoRoute(
    path: "/picker",
    name: "Picker",
    pageBuilder: withPage((uri) => PickerPage(uri)),
  ),
  GoRoute(
    path: "/radio",
    name: "Radio",
    pageBuilder: withPage((uri) => RadioPage(uri)),
  ),
  GoRoute(
    path: "/rate",
    name: "Rate",
    pageBuilder: withPage((uri) => RatePage(uri)),
  ),
  GoRoute(
    path: "/slider",
    name: "Slider",
    pageBuilder: withPage((uri) => SliderPage(uri)),
  ),
  GoRoute(
    path: "/input",
    name: "Input",
    pageBuilder: withPage((uri) => InputPage(uri)),
  ),
  GoRoute(
    path: "/switch",
    name: "Switch",
    pageBuilder: withPage((uri) => SwitchPage(uri)),
  ),
  GoRoute(
    path: "/form",
    name: "Form",
    pageBuilder: withPage((uri) => FormPage(uri)),
  ),
  GoRoute(
    path: "/actionsheet",
    name: "ActionSheet",
    pageBuilder: withPage((uri) => ActionSheetPage(uri)),
  ),
  GoRoute(
    path: "/dialog",
    name: "Dialog",
    pageBuilder: withPage((uri) => DialogPage(uri)),
  ),
  GoRoute(
    path: "/pull_to_refresh",
    name: "PullToRefresh",
    pageBuilder: withPage((uri) => PullToRefreshPage(uri)),
  ),
  GoRoute(
    path: "/swipe_cell",
    name: "SwipeCell",
    pageBuilder: withPage((uri) => SwipeCellPage(uri)),
  ),
  GoRoute(
    path: "/badge",
    name: "Badge",
    pageBuilder: withPage((uri) => BadgePage(uri)),
  ),
  GoRoute(
    path: "/divider",
    name: "Divider",
    pageBuilder: withPage((uri) => DividerPage(uri)),
  ),
  GoRoute(
    path: "/tag",
    name: "Tag",
    pageBuilder: withPage((uri) => TagPage(uri)),
  ),
  GoRoute(
    path: "/grid",
    name: "Grid",
    pageBuilder: withPage((uri) => GridPage(uri)),
  ),
  GoRoute(
    path: "/navbar",
    name: "NavBar",
    pageBuilder: withPage((uri) => NavBarPage(uri)),
  ),
  GoRoute(
    path: "/tabbar",
    name: "TabBar",
    pageBuilder: withPage((uri) => TabBarPage(uri)),
  ),
  GoRoute(
    path: "/date_picker",
    name: "DatePicker",
    pageBuilder: withPage((uri) => DatePickerPage(uri)),
  ),
  GoRoute(
    path: "/time_picker",
    name: "TimePicker",
    pageBuilder: withPage((uri) => TimePickerPage(uri)),
  ),
  GoRoute(
    path: "/index_bar",
    name: "IndexBar",
    pageBuilder: withPage((uri) => IndexBarPage(uri)),
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
