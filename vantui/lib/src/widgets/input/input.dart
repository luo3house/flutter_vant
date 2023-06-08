// ignore_for_file: annotate_overrides

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vantui/src/utils/rendering.dart';
import 'package:flutter_vantui/src/widgets/config/index.dart';
import 'package:flutter_vantui/src/widgets/form/types.dart';
import 'package:tailstyle/tailstyle.dart';

import '../../utils/nil.dart';

class VanInput extends StatefulWidget implements FormItemChild<String> {
  final String? value;
  final bool? autoFocus;
  final bool? obscureText;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final bool? disabled;
  final int? maxLength;
  final Function(String v)? onChange;
  final Function()? onFocus;
  final Function()? onBlur;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Color? cursorColor;
  final Color? bgCursorColor;
  final Color? selectionColor;
  final Color? bgColor;
  final Widget Function(Widget input)? as;

  const VanInput({
    this.value,
    this.autoFocus,
    this.obscureText,
    this.hint,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.disabled,
    this.keyboardType,
    this.textInputAction,
    this.onChange,
    this.onFocus,
    this.onBlur,
    this.textStyle,
    this.cursorColor,
    this.bgCursorColor,
    this.selectionColor,
    this.bgColor,
    this.as,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return VanInputState();
  }

  @override
  FormItemChild<String> cloneWithFormItemChild(
      {Function(String v)? onChange, String? value}) {
    return VanInput(
      value: value,
      autoFocus: autoFocus,
      obscureText: obscureText,
      hint: hint,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      disabled: disabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChange: onChange,
      onFocus: onFocus,
      onBlur: onBlur,
      textStyle: textStyle,
      cursorColor: cursorColor,
      bgCursorColor: bgCursorColor,
      selectionColor: selectionColor,
      as: as,
      key: key,
    );
  }
}

class VanInputState extends State<VanInput>
    implements TextSelectionGestureDetectorBuilderDelegate {
  final textKey = GlobalKey<EditableTextState>();
  final focusNode = FocusNode();
  final focusNodeFocus = ValueNotifier(false);
  final controller = TextEditingController();
  final keyboardVisible = ValueNotifier(false);

  int? get maxLines => obscureText ? 1 : widget.maxLines;
  bool get autoFocus => widget.autoFocus ?? false;
  bool get obscureText => widget.obscureText ?? false;
  bool get disabled => widget.disabled ?? false;
  String get hint => widget.hint ?? '';
  Color get selectionColor => widget.selectionColor ?? const Color(0xFFBBD6FB);

  focus() {
    focusNode.requestFocus();
  }

  blur() {
    focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    controller.text = widget.value ?? controller.text;
    keyboardVisible.addListener(
      () => raf(() {
        if (!keyboardVisible.value) blur();
      }),
    );
    focusNode.addListener(() {
      focusNodeFocus.value = focusNode.hasPrimaryFocus;
    });
    focusNodeFocus.addListener(() {
      if (focusNodeFocus.value) {
        widget.onFocus?.call();
      } else {
        widget.onBlur?.call();
      }
    });
  }

  @override
  void didUpdateWidget(covariant VanInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller.text != widget.value) {
      controller.text = widget.value ?? '';
    }
    if (keyboardVisible.value && disabled) {
      blur();
    }
  }

  @override
  GlobalKey<EditableTextState> get editableTextKey => textKey;

  @override
  bool get forcePressEnabled => false;

  @override
  bool get selectionEnabled => !disabled && !obscureText;

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    keyboardVisible.dispose();
    focusNodeFocus.dispose();
    super.dispose();
  }

  handleTap() {
    if (disabled) return;
    focus();
  }

  handleChanged(String value) {
    widget.onChange?.call(value);
    setState(() {});
  }

  TextInputFormatter maxLengthFormatter() {
    return LengthLimitingTextInputFormatter(
      widget.maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
    );
  }

  defaultAs(Widget input) => input;

  @override
  Widget build(BuildContext context) {
    final theme = VanConfig.ofTheme(context);
    final showHint = controller.text.isEmpty;
    raf(() {
      keyboardVisible.value =
          WidgetsBinding.instance.window.viewInsets.bottom > 0;
    });

    final textStyle = () {
      var style = DefaultTextStyle.of(context).style;
      if (disabled) {
        style = style.copyWith(color: theme.textColor3);
      } else {
        return style.copyWith(color: theme.textColor);
      }
    }();

    final editable = EditableText(
      key: textKey,
      keyboardType: widget.keyboardType,
      readOnly: disabled,
      minLines: widget.minLines,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      focusNode: disabled ? FocusNode(canRequestFocus: false) : focusNode,
      autofocus: disabled ? false : autoFocus,
      onChanged: handleChanged,
      style: textStyle ?? const TextStyle(),
      cursorColor: widget.cursorColor ?? theme.textColor,
      backgroundCursorColor: widget.bgCursorColor ?? theme.primaryColor,
      cursorWidth: 1.5,
      textInputAction: widget.textInputAction,
      selectionColor: selectionColor,
      inputFormatters: [maxLengthFormatter()],
    );

    final hint = () {
      if (!showHint) return nil;
      return Text(
        this.hint,
        style: textStyle?.copyWith(
          color: textStyle.color?.withAlpha(0x40),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }();

    final disabledMask = () {
      if (!disabled) return nil;
      return Positioned.fill(child: Container(color: const Color(0x00000000)));
    }();

    final bg = widget.bgColor ?? theme.background2;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleTap(),
      child: (widget.as ?? defaultAs).call(TailBox().bg(bg).py(0).as((s) {
        return s.Container(
          clipBehavior: Clip.hardEdge,
          child: Stack(alignment: Alignment.centerLeft, children: [
            Positioned.fill(child: Container(color: bg)),
            TextSelectionGestureDetectorBuilder(delegate: this)
                .buildGestureDetector(child: editable),
            IgnorePointer(child: hint),
            disabledMask,
          ]),
        );
      })),
    );
  }
}
