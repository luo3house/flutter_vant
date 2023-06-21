import 'package:flutter/widgets.dart';
import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';

class SwipeCellPage extends StatelessWidget {
  final Uri location;
  const SwipeCellPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      VanSwipeCell(
        left: const VanBtn(square: true, text: "选择", type: VanBtnType.primary),
        right: Row(mainAxisSize: MainAxisSize.min, children: const [
          VanBtn(square: true, text: "删除", type: VanBtnType.danger),
          VanBtn(square: true, text: "收藏", type: VanBtnType.primary),
        ]),
        child: const VanCell(title: "横扫", value: "内容"),
      ),

      //
      const DocTitle("点击关闭"),
      WithModel(GlobalKey<VanSwipeCellState>(), (model) {
        final key = model.value;
        return VanSwipeCell(
          key: key,
          right: Row(mainAxisSize: MainAxisSize.min, children: [
            VanBtn(
              square: true,
              text: "删除",
              type: VanBtnType.danger,
              onTap: () => key.currentState?.close(),
            ),
            VanBtn(
              square: true,
              text: "收藏",
              type: VanBtnType.primary,
              onTap: () => key.currentState?.close(),
            ),
          ]),
          child: const VanCell(title: "单元格", value: "内容"),
        );
      }),

      //
      const DocTitle("自定义渲染"),
      WithModel(
        List.generate(3, (_) => GlobalKey<VanSwipeCellState>()),
        (model) {
          right(GlobalKey<VanSwipeCellState> key) {
            return Row(mainAxisSize: MainAxisSize.min, children: [
              VanBtn(
                type: VanBtnType.warning,
                square: true,
                text: "置顶",
                onTap: () => key.currentState?.close(),
              ),
              VanBtn(
                type: VanBtnType.danger,
                square: true,
                text: "删除",
                onTap: () => key.currentState?.close(),
              ),
            ]);
          }

          return Column(mainAxisSize: MainAxisSize.min, children: [
            VanSwipeCell(
              key: model.value[0],
              right: right(model.value[0]),
              child: const VanCell(
                prefix: VanBadge(
                  dot: true,
                  child: Icon(VanIcons.smile_comment_o, size: 28),
                ),
                title: "友人 A",
                label: "今晚去吃寿司怎么样？",
              ),
            ),
            VanSwipeCell(
              key: model.value[1],
              right: right(model.value[1]),
              child: const VanCell(
                prefix: VanBadge(
                  content: 40,
                  child: Icon(VanIcons.orders_o, size: 28),
                ),
                title: "生活号",
                label: "紧急扩散！！为什么这不能吃那不能吃？",
              ),
            ),
            VanSwipeCell(
              key: model.value[2],
              right: right(model.value[2]),
              child: const VanCell(
                prefix: Icon(VanIcons.bullhorn_o, size: 28),
                title: "水电费",
                label: "本月水电费用已出单",
              ),
            ),
          ]);
        },
      ),

      //
    ]);
  }
}
