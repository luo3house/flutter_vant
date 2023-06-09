import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class ToastPage extends StatelessWidget {
  final Uri location;
  const ToastPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      VanCellGroup(children: [
        VanCell(
          title: "文字提示",
          clickable: true,
          onTap: () => VanToastStatic.show(context, message: "提示内容"),
        ),
        VanCell(
          title: "加载提示",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            type: VanToastType.loading,
            message: "加载中...",
          ),
        ),
        VanCell(
          title: "成功提示",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            type: VanToastType.success,
            message: "成功文案",
          ),
        ),
        VanCell(
          title: "失败提示",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            type: VanToastType.fail,
            message: "失败文案",
          ),
        ),
      ]),
      const DocTitle("自定义图标"),
      VanCellGroup(children: [
        VanCell(
          title: "自定义图标",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            message: "自定义图标",
            icon: VanIcons.like_o,
          ),
        ),
        VanCell(
          title: "自定义图片",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            icon: Image.network(
              "https://fastly.jsdelivr.net/npm/@vant/assets/logo.png",
              width: 32,
              height: 32,
            ),
            message: "自定义图片",
          ),
        ),
      ]),
      const DocTitle("自定义位置"),
      VanCellGroup(children: [
        VanCell(
          title: "顶部展示",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            position: VanToastPosition.top,
            message: "顶部展示",
          ),
        ),
        VanCell(
          title: "底部展示",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            position: VanToastPosition.bottom,
            message: "底部展示",
          ),
        ),
      ]),
      const DocTitle("自定义绘制"),
      VanCellGroup(children: [
        VanCell(
          title: "自定义绘制",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            padding: EdgeInsets.zero,
            message: Image.network(
              "https://fastly.jsdelivr.net/npm/@vant/assets/cat.jpeg",
              width: 200,
              height: 140,
            ),
          ),
        ),
      ]),
      const DocTitle("多实例"),
      VanCellGroup(children: [
        VanCell(
          title: "A",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            position: VanToastPosition.top,
            message: "多实例 A",
            key: "AToast",
          ),
        ),
        VanCell(
          title: "B",
          clickable: true,
          onTap: () => VanToastStatic.show(
            context,
            position: VanToastPosition.bottom,
            message: "多实例 B",
            key: "BToast",
          ),
        ),
      ]),
    ]);
  }
}
