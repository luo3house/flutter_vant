import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:tailstyle/tailstyle.dart';
import 'package:flutter/widgets.dart';

class DialogPage extends StatelessWidget {
  final Uri location;
  const DialogPage(this.location, {super.key});

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
                  ..title = "Title"
                  ..message = "如果解决方法是丑陋的，那就肯定还有更好的解决方法，只是还没有发现而已。";
              },
            ),
            VanCell(
              title: "Untitled",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..message = "生命远不止连轴转和忙到极限，人类的体验远比这辽阔、丰富得多。";
              },
            ),
            VanCell(
              title: "Confirm (Cancel + OK)",
              clickable: true,
              onTap: () {
                model.value = _State()
                  ..show = true
                  ..onClose = (() {
                    model.value = model.value.clone()..show = false;
                  })
                  ..action = VanDialogConfirm(
                    onOK: () => VanToastStatic.show(context, message: "Yep"),
                    onCancel: () =>
                        VanToastStatic.show(context, message: "Not"),
                    okText: "Yep",
                    cancelText: "Not",
                  )
                  ..title = "Title"
                  ..message = "如果解决方法是丑陋的，那就肯定还有更好的解决方法，只是还没有发现而已。";
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
                  ..action = VanDialogConfirm(
                    onCancel: () {},
                  )
                  ..title = "Title"
                  ..message = TailBox().p(20).Container(
                        child: Image.network(
                            "https://fastly.jsdelivr.net/npm/@vant/assets/apple-3.jpeg"),
                      );
              },
            ),
          ]),
          VanDialog(
            show: model.value.show,
            title: model.value.title,
            message: model.value.message,
            action: model.value.action,
            constraints: model.value.constraints,
            closeOnClickOverlay: model.value.closeOnClickOverlay,
            onClose: model.value.onClose,
            onInvalidate: model.value.onInvalidate,
          ),
        ],
      );
    });
  }
}

class _State {
  bool? show;
  dynamic title;
  dynamic message;
  DialogActionLike? action;
  BoxConstraints? constraints;
  bool? closeOnClickOverlay;
  Function()? onClose;
  Function()? onInvalidate;
  clone() {
    return _State()
      ..show = show
      ..title = title
      ..message = message
      ..action = action
      ..constraints = constraints
      ..closeOnClickOverlay = closeOnClickOverlay
      ..onClose = onClose
      ..onInvalidate = onInvalidate;
  }
}
