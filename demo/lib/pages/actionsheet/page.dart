import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' show Colors;

class ActionSheetPage extends StatelessWidget {
  final Uri location;
  const ActionSheetPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return WithModel<_State>(_State(), (model) {
      return Stack(
        children: [
          ListView(children: [
            const DocTitle("Basic Usage"),
            VanCell(
              title: "Basic Usage",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..closeOnClickAction = true
                  ..actions = [
                    const VanActionSheetItem("Option1"),
                    const VanActionSheetItem("Option2"),
                    const VanActionSheetItem("Option3"),
                  ]
                  ..onSelect = (item) {
                    VanToastStatic.show(context, message: item.name);
                  };
              },
            ),
            VanCell(
              title: "With Cancel",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..actions = [
                    const VanActionSheetItem("Option1"),
                    const VanActionSheetItem("Option2"),
                  ]
                  ..cancelText = "Cancel"
                  ..onCancel = () {
                    VanToastStatic.show(context, message: "Cancel");
                  };
              },
            ),
            VanCell(
              title: "With Description",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..description = "My Description"
                  ..cancelText = "Cancel"
                  ..actions = [
                    const VanActionSheetItem("Option1"),
                    const VanActionSheetItem("Option2"),
                  ];
              },
            ),

            //
            const DocTitle("Custom"),
            VanCell(
              title: "Custom",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..description = "My Description"
                  ..actions = [
                    VanActionSheetItem(
                      "Option1",
                      child: TailTypo() //
                          .text_color(Colors.red)
                          .Text("Option1"),
                    ),
                    const VanActionSheetItem("Option2", disabled: true),
                  ];
              },
            ),
          ]),
          VanActionSheet(
            show: model.value.show,
            actions: model.value.actions,
            description: model.value.description,
            cancelText: model.value.cancelText,
            closeOnClickAction: model.value.closeOnClickAction,
            onClose: model.value.onClose,
            onCancel: model.value.onCancel,
            onSelect: model.value.onSelect,
          ),
        ],
      );
    });
  }
}

class _State {
  bool? show;
  List<VanActionSheetItem>? actions;
  String? description;
  String? cancelText;
  bool? closeOnClickAction;
  Function()? onClose;
  Function()? onCancel;
  Function(VanActionSheetItem item)? onSelect;
  clone() {
    return _State()
      ..show = show
      ..actions = actions
      ..description = description
      ..cancelText = cancelText
      ..closeOnClickAction = closeOnClickAction
      ..onClose = onClose
      ..onCancel = onCancel
      ..onSelect = onSelect;
  }
}
