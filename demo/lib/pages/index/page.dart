import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:go_router/go_router.dart';
import 'package:tailstyle/tailstyle.dart';

class IndexPage extends StatelessWidget {
  final Uri location;
  const IndexPage(this.location, {super.key});

  void push(BuildContext context, String path) {
    GoRouter.of(context).push(Uri(path: path).toString());
  }

  Iterable<Widget> mapWithGutter(Iterable<Widget> children) {
    return children.map(
      (child) => TailBox().mb(10).px(10).Container(child: child),
    );
  }

  Iterable<Widget> mapWithBold(Iterable<Widget> children) {
    return children.map((child) => DefaultTextStyle(
          style: TailTypo().font_bold().text_left().TextStyle(),
          child: child,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final links = <String, Function()>{
      "Button 按钮": () => push(context, "/button"),
      "Icon 图标": () => push(context, "/icon"),
      "Cell 单元格": () => push(context, "/cell"),
      "Layout 布局": () => push(context, "/layout"),
      "Toast 轻提示": () => push(context, "/toast"),
      "Popup 弹出层": () => push(context, "/popup"),
      "Calendar 日历": () => push(context, "/calendar"),
      "Tab 标签页": () => push(context, "/tab"),
      "Swipe 轮播": () => push(context, "/swipe"),
      "Cascader 级联选择": () => push(context, "/cascader"),
      "Checkbox 复选框": () => push(context, "/checkbox"),
      "Picker 选择器组": () => push(context, "/picker"),
      "Radio 单选框": () => push(context, "/radio"),
      "Rate 评分": () => push(context, "/rate"),
      "Slider 滑块": () => push(context, "/slider"),
      "Input 输入框": () => push(context, "/input"),
      "Switch 开关": () => push(context, "/switch"),
      "Form 表单": () => push(context, "/form"),
      "ActionSheet 动作面板": () => push(context, "/actionsheet"),
      "Dialog 弹出框": () => push(context, "/dialog"),
      "PullToRefresh 下拉刷新": () => push(context, "/pull_to_refresh"),
      "SwipeCell 滑动单元格": () => push(context, "/swipe_cell"),
      "Badge 徽标": () => push(context, "/badge"),
      "Divider 分割线": () => push(context, "/divider"),
      "Tag 标签": () => push(context, "/tag"),
      "Grid 宫格": () => push(context, "/grid"),
      "NavBar 导航栏": () => push(context, "/navbar"),
      "TabBar 标签栏": () => push(context, "/tabbar"),
      "DatePicker 日期选择器": () => push(context, "/date_picker"),
      "TimePicker 时间选择器": () => push(context, "/time_picker"),
      "IndexBar 索引列表": () => push(context, "/index_bar"),
      "OTPInput 密码输入框": () => push(context, "/otp_input"),
    };

    final h1 = TailTypo().text_xl().font_bold();
    final h2 = TailTypo().text_color(TailColors.gray_400).text_base();
    final row = TailBox().px(20).mb(10);
    final item = TailBox().mb(10).px(10);

    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: TailBox().mb(10).py(30).as((s) {
          return s.Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                row.Container(child: h1.Text("Flutter Vant UI")),
                row.Container(child: h2.Text("轻量、快速的 Flutter 端组件")),
              ],
            ),
          );
        }),
      ),
      SliverToBoxAdapter(child: row.Container(child: h2.Text("基础组件"))),
      SliverFixedExtentList(
        itemExtent: 50,
        delegate: SliverChildBuilderDelegate(
          childCount: links.length,
          (_, index) {
            final text = links.keys.elementAt(index);
            final onTap = links[links.keys.elementAt(index)]!;
            return Align(
              alignment: Alignment.centerLeft,
              child: item.Container(
                child: VanBtn(
                  round: true,
                  plain: true,
                  text: text,
                  onTap: onTap,
                  block: true,
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
