import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../config/index.dart';
import '../navbar/navbar.dart';

class PickerToolBar extends StatelessWidget {
  final dynamic title;
  final String? cancelText;
  final String? confirmText;
  final Function()? onCancel;
  final Function()? onConfirm;

  const PickerToolBar({
    this.title,
    this.cancelText,
    this.confirmText,
    this.onCancel,
    this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    return NavBar(
      title: title ?? "标题",
      leftArrow: false,
      leftText: TailTypo() //
          .text_color(theme.textColor2)
          .Text(cancelText ?? '取消'),
      rightText: confirmText ?? '确认',
      onLeftTap: onCancel,
      onRightTap: onConfirm,
      noBorder: true,
    );
  }
}
