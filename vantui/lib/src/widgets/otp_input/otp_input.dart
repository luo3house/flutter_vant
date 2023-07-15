import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/grid_util.dart';
import 'package:flutter_vantui/src/widgets/_util/with_value.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';
import '../_util/hidden.dart';
import '../config/index.dart';
import '../input/input.dart';

// @DocsId("otp_input")

class OTPInput extends StatefulWidget {
  // @DocsProp("value", "String", "当前值")
  final String? value;
  // @DocsProp("length", "int", "最大长度")
  final int? length;
  // @DocsProp("gutter", "double", "间距")
  final double? gutter;
  // @DocsProp("obsecure", "bool", "隐藏文本")
  final bool? obsecure;
  // @DocsProp("autoFocus", "bool", "自动聚焦")
  final bool? autoFocus;
  // @DocsProp("onChange", "Function(String codes)", "值变化回调")
  final Function(String value)? onChange;
  // @DocsProp("onComplete", "Function(String codes)", "输入到达长度时触发")
  final Function(String value)? onComplete;

  const OTPInput({
    this.value,
    this.length,
    this.gutter,
    this.obsecure,
    this.autoFocus,
    this.onChange,
    this.onComplete,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return OTPInputState();
  }
}

class OTPInputState extends State<OTPInput> {
  static final digitRE = RegExp("[0-9]");

  final focusNode = FocusNode();
  var chars = "";

  bool get isFocusing => focusNode.hasFocus;
  int get length => widget.length ?? 6;

  @override
  void initState() {
    super.initState();
    chars = widget.value ?? '';
    focusNode.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant OTPInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && chars != widget.value) {
      chars = widget.value!;
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  handleCharsChange(String v) {
    if (chars != v) {
      chars = v;
      setState(() {});
      widget.onChange?.call(chars);
      if (chars.length >= length) widget.onComplete?.call(chars);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    final gutter = widget.gutter ?? 0.0;
    final obsecure = widget.obsecure == true;
    final autoFocus = widget.autoFocus ?? false;
    const height = 50.0;

    final mx = theme.paddingMd;

    final borderW = gutter > 0 ? 0.0 : 1.0;
    final borderC = theme.borderColor;

    return FocusTrapArea(
      focusNode: focusNode,
      child: Input(
        keyboardType: const TextInputType.numberWithOptions(),
        autoFocus: autoFocus,
        focusNode: focusNode,
        maxLength: length,
        value: chars,
        onChange: (v) => handleCharsChange(v),
        inputFormatters: [FilteringTextInputFormatter.allow(digitRE)],
        showCursor: false,
        showSelectionHandles: false,
        toolbarOptions: Input.noToolbarOptions,
        as: (input) {
          return Stack(alignment: Alignment.bottomLeft, children: [
            // paint render box is required to get caret size to scrolling widget to screen
            // but Opacity(opacity: 0) skips painting and only performs layout, and Offstage as well
            Hidden(child: input),
            TailBox().border(borderC, borderW).mx(mx).as((s) {
              return s.Container(
                height: height,
                child: LayoutBuilder(builder: (_, con) {
                  final gaps = GridUtil.gutter(con.maxWidth, length, gutter);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(length, (index) {
                      final slotFocusing = index == chars.length ||
                          // (chars.length == length && index + 1 == length);
                          false;
                      final borderW = index == 0 ? 0.0 : 1.0;
                      return TailBox()
                          .ml(index == 0 ? 0.0 : gaps.subsequentLeft)
                          .border_l(borderC, borderW)
                          .Container(
                            width: gaps.itemDim,
                            child: _OTPInputSlot(
                              obsecure: obsecure,
                              focusing: isFocusing && slotFocusing,
                              char: chars.length > index ? chars[index] : '',
                            ),
                          );
                    }),
                  );
                }),
              );
            }),
          ]);
        },
      ),
    );
  }
}

class _OTPInputSlot extends StatelessWidget {
  final bool focusing;
  final bool obsecure;
  final String char;
  const _OTPInputSlot({
    required this.focusing,
    required this.obsecure,
    required this.char,
  });

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);

    const dotSize = 10.0;
    const fontSize = 20.0;
    final color = theme.textColor;

    final textStyle =
        TailTypo().font_size(fontSize).text_color(color).TextStyle();

    final dot = Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );

    return LayoutBuilder(builder: (_, con) {
      final height = con.maxHeight * .4;
      final cursorAnim = WithValue(true, (model) {
        return TweenAnimationBuilder(
          tween: model.value
              ? Tween(begin: 0.0, end: 1.0)
              : Tween(begin: 1.0, end: 0.0),
          duration: const Duration(milliseconds: 500),
          onEnd: () => model.value = !model.value,
          builder: (_, x, child) => Opacity(opacity: x, child: child),
          child: Container(color: color, height: height, width: 1),
        );
      });

      final bg = theme.background2;

      return DefaultTextStyle(
        style: textStyle,
        child: Container(
          color: bg,
          child: Center(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              char.isEmpty
                  ? nil
                  : obsecure
                      ? dot
                      : Text(char),
              focusing ? cursorAnim : nil,
            ]),
          ),
        ),
      );
    });
  }
}
