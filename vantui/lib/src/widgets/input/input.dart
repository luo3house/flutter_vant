// ignore_for_file: annotate_overrides

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import '../config/index.dart';
import '../form/types.dart';
import '../../utils/nil.dart';

class Input extends StatefulWidget implements FormItemChild<String> {
  final String? value;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final bool? obscureText;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final bool? disabled;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
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

  const Input({
    this.value,
    this.autoFocus,
    this.focusNode,
    this.obscureText,
    this.hint,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.disabled,
    this.controller,
    this.inputFormatters,
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
    return InputState();
  }

  @override
  FormItemChild<String> cloneWithFormItemChild(
      {Function(String v)? onChange, String? value}) {
    return Input(
      value: value,
      autoFocus: autoFocus,
      obscureText: obscureText,
      hint: hint,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      disabled: disabled,
      controller: controller,
      focusNode: focusNode,
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

class InputState extends State<Input>
    implements TextSelectionGestureDetectorBuilderDelegate {
  final textKey = GlobalKey<EditableTextState>();
  late FocusNode focusNode;
  final focusNodeFocus = ValueNotifier(false);
  late TextEditingController controller;
  late TextSelectionGestureDetectorBuilder gestureDetectorBuilder;

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
    gestureDetectorBuilder = VanInputStateSelectionBuilder(this);
    focusNode = widget.focusNode ?? FocusNode();
    controller = widget.controller ?? TextEditingController();
    controller.text = widget.value ?? controller.text;
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
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller.text != widget.value) {
      controller.text = widget.value ?? '';
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
    if (widget.focusNode == null) focusNode.dispose();
    if (widget.controller == null) controller.dispose();
    focusNodeFocus.dispose();
    super.dispose();
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
      inputFormatters: [maxLengthFormatter(), ...?widget.inputFormatters],
      rendererIgnoresPointer: true,
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

    final wrap = (widget.as ?? defaultAs).call(TailBox().bg(bg).py(0).as((s) {
      return s.Container(
        clipBehavior: Clip.hardEdge,
        child: Stack(alignment: Alignment.centerLeft, children: [
          Positioned.fill(child: Container(color: bg)),
          editable,
          IgnorePointer(child: hint),
          disabledMask,
        ]),
      );
    }));

    return FocusTrapArea(
      focusNode: focusNode,
      child: gestureDetectorBuilder.buildGestureDetector(
        behavior: HitTestBehavior.translucent,
        child: wrap,
      ),
    );
  }
}

class VanInputStateSelectionBuilder
    extends TextSelectionGestureDetectorBuilder {
  final InputState state;
  VanInputStateSelectionBuilder(this.state) : super(delegate: state);

  @override
  void onForcePressStart(ForcePressDetails details) {
    super.onForcePressStart(details);
    if (delegate.selectionEnabled && shouldShowSelectionToolbar) {
      editableText.showToolbar();
    }
  }

  @override
  void onForcePressEnd(ForcePressDetails details) {
    // Not required.
  }

  @override
  void onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details) {
    if (delegate.selectionEnabled) {
      renderEditable.selectPositionAt(
        from: details.globalPosition,
        cause: SelectionChangedCause.longPress,
      );
    }
  }

  @override
  void onSingleTapUp(TapUpDetails details) {
    editableText.hideToolbar();
    super.onSingleTapUp(details);
    editableText.requestKeyboard();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    if (delegate.selectionEnabled) {
      renderEditable.selectPositionAt(
        from: details.globalPosition,
        cause: SelectionChangedCause.longPress,
      );
    }
  }
}
