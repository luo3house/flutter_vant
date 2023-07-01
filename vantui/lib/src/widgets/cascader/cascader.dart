import 'package:flutter/widgets.dart';

import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../_util/touch_opacity.dart';
import '../config/index.dart';
import '../icon/index.dart';
import '../navbar/navbar.dart';
import 'panel.dart';

class Cascader extends CascaderPanel {
  final String? title;
  final Function()? onClose;
  const Cascader({
    this.title,
    this.onClose,
    super.options,
    super.values,
    super.onChange,
    super.onOptionChange,
    super.onCascadeEnd,
    super.expands,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _CascaderState();
  }
}

class _CascaderState extends State<Cascader> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final onClose = widget.onClose;
    final options = widget.options;
    final values = widget.values;
    final onChange = widget.onChange;
    final onOptionChange = widget.onOptionChange;
    final onCascadeEnd = widget.onCascadeEnd;
    final expands = widget.expands;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      CascaderToolBar(title: title, onClose: onClose),
      Expanded(
        flex: expands == true ? 1 : 0,
        child: CascaderPanel(
          options: options,
          values: values,
          onChange: onChange,
          onOptionChange: onOptionChange,
          onCascadeEnd: onCascadeEnd,
          expands: expands,
        ),
      ),
    ]);
  }
}

class CascaderToolBar extends StatelessWidget {
  final String? title;
  final Function()? onClose;
  const CascaderToolBar({
    this.title,
    this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final textStyle = TailTypo() //
        .font_size(theme.fontSizeLg)
        .text_color(theme.textColor)
        .font_bold()
        .TextStyle();

    final iconTheme = IconThemeData(color: theme.gray5, size: 22.0);

    return VanNavBar(
      title: nil,
      // leftArrow: VanIcons.add,
      leftArrow: DefaultTextStyle(
        style: textStyle,
        child: Text(title ?? ''),
      ),
      rightText: IconTheme(
        data: iconTheme,
        child: TouchOpacity(
          onTap: onClose,
          child: const Icon(VanIcons.cross),
        ),
      ),
    );
  }
}
