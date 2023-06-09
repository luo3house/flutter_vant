import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class TabBarPage extends StatelessWidget {
  final Uri location;
  const TabBarPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      WithModel(0, (model) {
        return TabBar(
          value: model.value,
          onChange: (value) => model.value = value,
          children: const [
            TabBarItem(value: 0, text: "Home", icon: VanIcons.home_o),
            TabBarItem(value: 1, text: "Search", icon: VanIcons.search),
            TabBarItem(value: 2, text: "DM", icon: VanIcons.friends_o),
            TabBarItem(value: 3, text: "Me", icon: VanIcons.user_o),
          ],
        );
      }),

      //
      const DocTitle("Badge"),
      WithModel(0, (model) {
        return TabBar(
          value: model.value,
          onChange: (value) => model.value = value,
          children: const [
            TabBarItem(
              value: 0,
              text: "Home",
              icon: VanIcons.home_o,
            ),
            TabBarItem(
              value: 1,
              text: "Search",
              icon: VanIcons.search,
              dot: true,
            ),
            TabBarItem(
              value: 2,
              text: "DM",
              icon: VanIcons.friends_o,
              badge: "3",
            ),
            TabBarItem(
              value: 3,
              text: "Setting",
              icon: VanIcons.setting_o,
              badge: 20,
            ),
          ],
        );
      }),

      //
      const DocTitle("Custom Draw Icon"),
      WithModel(0, (model) {
        return TabBar(
          value: model.value,
          onChange: (value) => model.value = value,
          children: [
            TabBarItem(
              value: 0,
              text: "Custom",
              badge: 3,
              drawIcon: (selected) => Image.network(
                selected
                    ? "https://fastly.jsdelivr.net/npm/@vant/assets/user-active.png"
                    : "https://fastly.jsdelivr.net/npm/@vant/assets/user-inactive.png",
              ),
            ),
            const TabBarItem(value: 1, text: "Search", icon: VanIcons.search),
            const TabBarItem(value: 2, text: "DM", icon: VanIcons.friends_o),
          ],
        );
      }),

      //
      const DocTitle("Custom Draw Icon"),
      WithModel(0, (model) {
        return TabBar(
          value: model.value,
          onChange: (value) => model.value = value,
          activeColor: const Color(0xFFee0a24),
          children: const [
            TabBarItem(value: 0, text: "Home", icon: VanIcons.home_o),
            TabBarItem(value: 1, text: "Search", icon: VanIcons.search),
            TabBarItem(value: 2, text: "DM", icon: VanIcons.friends_o),
            TabBarItem(value: 3, text: "More", icon: VanIcons.setting_o),
          ],
        );
      }),

      //
      const DocTitle("Icon Only"),
      WithModel(0, (model) {
        return TabBar(
          value: model.value,
          onChange: (value) => model.value = value,
          children: const [
            TabBarItem(value: 0, icon: VanIcons.home_o),
            TabBarItem(value: 1, icon: VanIcons.search),
            TabBarItem(value: 2, icon: VanIcons.friends_o),
            TabBarItem(value: 3, icon: VanIcons.setting_o, dot: true),
          ],
        );
      }),
    ]);
  }
}
