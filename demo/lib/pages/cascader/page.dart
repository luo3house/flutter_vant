import 'package:demo/doc/doc_title.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class CascaderPage extends StatelessWidget {
  final Uri location;
  const CascaderPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("Basic Usage"),
      SizedBox(
        height: 300,
        child: VanCascader(
          options: [
            NestedNamedValue("a", "a", [
              NestedNamedValue("a.1", "a.1"),
              NestedNamedValue("a.2", "a.2"),
            ]),
            NestedNamedValue("b", "b", [
              NestedNamedValue("b.1", "b.1"),
              NestedNamedValue("b.2", "b.2"),
              NestedNamedValue("b.3", "b.3"),
            ]),
          ],
        ),
      ),
      const DocTitle("Async Load"),
      Builder(builder: (_) {
        final dataSource = ValueNotifier([
          NestedNamedValue("a", "a", []),
          NestedNamedValue("b", "b", []),
          NestedNamedValue("c", "c", null),
        ]);
        return SizedBox(
          height: 300,
          child: ValueListenableBuilder(
            valueListenable: dataSource,
            builder: (_, options, __) {
              return VanCascader(
                options: options,
                onChange: (values) {
                  final match = VanCascader.matchOptionsByValues(
                    options,
                    values,
                  ).last;
                  if (match?.children?.isEmpty == true) {
                    Future.delayed(const Duration(seconds: 2), () {
                      match!.children = [
                        NestedNamedValue("${match.name}.1", 1),
                        NestedNamedValue("${match.name}.2", 2),
                      ];
                      dataSource.value = List.of(options);
                    });
                  }
                },
              );
            },
          ),
        );
      }),
    ]);
  }
}
