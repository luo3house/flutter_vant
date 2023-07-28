// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tailstyle/tailstyle.dart';

import 'selection_controls.dart';
import '../config/index.dart';
import '../form/types.dart';
import '../../utils/nil.dart';

// @DocsId("input")

class Input extends StatefulWidget implements FormItemChild<String> {
  static const defaultToolbarOptions =
      ToolbarOptions(copy: true, cut: true, selectAll: true, paste: true);
  static const obscureToolbarOptions =
      ToolbarOptions(copy: false, cut: false, selectAll: false, paste: true);
  static const noToolbarOptions =
      ToolbarOptions(copy: false, cut: false, selectAll: false, paste: false);

  // @DocsProp("value", "String", "当前值")
  final String? value;
  // @DocsProp("autoFocus", "bool", "自动聚焦")
  final bool? autoFocus;
  // @DocsProp("focusNode", "FocusNode", "聚焦对象")
  final FocusNode? focusNode;
  // @DocsProp("obscureText", "bool", "隐藏文本")
  final bool? obscureText;
  // @DocsProp("hint", "String", "输入提示")
  final String? hint;
  // @DocsProp("minLines", "int", "最小行")
  final int? minLines;
  // @DocsProp("maxLines", "int", "最大行")
  final int? maxLines;
  // @DocsProp("disabled", "bool", "禁用状态")
  final bool? disabled;
  // @DocsProp("maxLength", "int", "最大长度")
  final int? maxLength;
  // @DocsProp("controller", "TextEditingController", "控制器")
  final TextEditingController? controller;
  // @DocsProp("inputFormatters", "List<TextInputFormatter>", "文本格式化")
  final List<TextInputFormatter>? inputFormatters;
  // @DocsProp("onChange", "Function(String value)", "值变化回调")
  final Function(String v)? onChange;
  // @DocsProp("onFocus", "Function()", "聚焦时回调")
  final Function()? onFocus;
  // @DocsProp("onBlur", "Function()", "失去焦点回调")
  final Function()? onBlur;
  // @DocsProp("keyboardType", "TextInputType", "系统键盘风格")
  final TextInputType? keyboardType;
  // @DocsProp("textInputAction", "TextInputAction", "系统键盘「确认」键风格")
  final TextInputAction? textInputAction;
  // @DocsProp("toolbarOptions", "ToolbarOptions", "框选选项，可配置复制、粘贴、全选、剪切功能")
  final ToolbarOptions? toolbarOptions;
  // @DocsProp("selectionControls", "TextSelectionControls", "框选控制")
  final TextSelectionControls? selectionControls;
  // @DocsProp("textStyle", "TextStyle", "文本样式")
  final TextStyle? textStyle;
  // @DocsProp("showCursor", "bool", "展示光标"")
  final bool? showCursor;
  // @DocsProp("showSelectionHandles", "bool", "展示框选光标")
  final bool? showSelectionHandles;
  // @DocsProp("cursorColor", "Color", "光标颜色")
  final Color? cursorColor;
  // @DocsProp("bgCursorColor", "Color", "背景光标颜色")
  final Color? bgCursorColor;
  // @DocsProp("selectionColor", "Color", "框选浮层颜色")
  final Color? selectionColor;
  // @DocsProp("bgColor", "Color", "背景颜色")
  final Color? bgColor;
  // @DocsProp("as", "Widget Function(Widget input)", "绘制代理，可用于自定义绘制")
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
    this.toolbarOptions,
    this.selectionControls,
    this.showCursor,
    this.showSelectionHandles,
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
      toolbarOptions: toolbarOptions,
      selectionControls: selectionControls,
      showCursor: showCursor,
      showSelectionHandles: showSelectionHandles,
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
  var _showSelectionHandles = false;

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
    if (oldWidget.value != widget.value && controller.text != widget.value) {
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

  bool _shouldShowSelectionHandles(SelectionChangedCause? cause) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.
    if (!gestureDetectorBuilder.shouldShowSelectionToolbar) {
      return false;
    }

    if (cause == SelectionChangedCause.keyboard) {
      return false;
    }

    if (cause == SelectionChangedCause.longPress ||
        cause == SelectionChangedCause.scribble) {
      return true;
    }

    if (controller.text.isNotEmpty) {
      return true;
    }

    return false;
  }

  _handleSelectionChanged(
      TextSelection selection, SelectionChangedCause? cause) {
    final bool willShowSelectionHandles = _shouldShowSelectionHandles(cause);
    if (willShowSelectionHandles != _showSelectionHandles) {
      setState(() {
        _showSelectionHandles = willShowSelectionHandles;
      });
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        if (cause == SelectionChangedCause.longPress ||
            cause == SelectionChangedCause.drag) {
          editableTextKey.currentState?.bringIntoView(selection.extent);
        }
        return;
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.fuchsia:
      case TargetPlatform.android:
        if (cause == SelectionChangedCause.drag) {
          editableTextKey.currentState?.bringIntoView(selection.extent);
        }
        return;
    }
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
        return style.copyWith(color: theme.textColor3);
      } else {
        return style.copyWith(color: theme.textColor);
      }
    }();

    final toolbarOptions = widget.toolbarOptions ??
        (obscureText
            ? Input.obscureToolbarOptions
            : Input.defaultToolbarOptions);

    final selectionControls = widget.selectionControls ??
        PlatformDefaultTextSelectionControls.decorateFromPlatform(
            context, defaultTargetPlatform);

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
      style: textStyle,
      cursorColor: widget.cursorColor ?? theme.textColor,
      backgroundCursorColor: widget.bgCursorColor ?? theme.primaryColor,
      cursorWidth: 1.5,
      textInputAction: widget.textInputAction,
      selectionColor: selectionColor,
      inputFormatters: [maxLengthFormatter(), ...?widget.inputFormatters],
      rendererIgnoresPointer: true,
      toolbarOptions: toolbarOptions,
      selectionControls: selectionControls,
      showCursor: widget.showCursor,
      showSelectionHandles:
          widget.showSelectionHandles ?? _showSelectionHandles,
      onSelectionChanged: _handleSelectionChanged,
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

    return gestureDetectorBuilder.buildGestureDetector(
      behavior: HitTestBehavior.translucent,
      child: wrap,
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
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectWordsInRange(
            from: details.globalPosition - details.offsetFromOrigin,
            to: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
      }
    }
  }

  @override
  void onSingleTapUp(TapDragUpDetails details) {
    editableText.hideToolbar();
    super.onSingleTapUp(details);
    editableText.requestKeyboard();
  }

  @override
  void onSingleLongTapStart(LongPressStartDetails details) {
    if (delegate.selectionEnabled) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          renderEditable.selectPositionAt(
            from: details.globalPosition,
            cause: SelectionChangedCause.longPress,
          );
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          renderEditable.selectWord(cause: SelectionChangedCause.longPress);
          editableText.showToolbar();
          break;
      }
    }
  }
}
