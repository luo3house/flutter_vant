import 'dart:async';

import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/child.dart';
import 'package:demo/widgets/watch_model.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

import 'area.dart';

// @DocsId("cascader")
// @DocsWidget("Cascader 级联选择")

class CascaderPage extends StatefulWidget {
  final Uri location;
  const CascaderPage(this.location, {super.key});

  @override
  State<StatefulWidget> createState() {
    return CascaderPageState();
  }
}

class CascaderPageState extends State<CascaderPage> {
  final basicShow = ValueNotifier(false);
  final basicValues = ValueNotifier<List>(const []);

  final asyncShow = ValueNotifier(false);
  final asyncOptions = ValueNotifier(
    [NamedValueOption("浙江省", "Zhejiang", [])],
  );
  final asyncValues = ValueNotifier<List>(const []);

  String formatValues(List<NamedValueOption> options, List values) {
    const empty = <NamedValueOption>[];
    List<NamedValueOption>? opts = options;
    final result = List.of(values.map((value) {
      final match = INamedValueOption.findByValue(opts ?? empty, value);
      opts = match?.children;
      return match?.name ?? '';
    }));
    return result.isEmpty ? '请选择地区' : result.join('/');
  }

  @override
  Widget build(BuildContext context) {
    NilChild(
      // @DocsDemo("基本用法")
      Cascader(
        options: [
          NamedValueOption("浙江省", "Zhejiang", [
            NamedValueOption("杭州市", "Hangzhou", [
              NamedValueOption("上城区", "Shangcheng"),
              NamedValueOption("下城区", "Xiacheng"),
            ]),
            NamedValueOption("宁波市", "Ningbo", [
              NamedValueOption("海曙区", "Haishu"),
              NamedValueOption("江北区", "Jiangbei"),
            ]),
          ]),
        ],
        values: const ["Zhejiang"],
        onChange: (values) => {/* 每次点选触发 */},
        onCascadeEnd: (values) => {/* 选择完毕触发 */},
      ),
      // @DocsDemo
    );

    StatefulBuilder(builder: (_, setState) {
      return NilChild(
        // @DocsDemo("异步加载")
        Cascader(
          options: [
            NamedValueOption("浙江省", "Zhejiang", [
              // 空数组，异步填充
            ]),
          ],
          onOptionChange: (values, selected) {
            if (selected.children == null) return;
            if (selected.children!.isEmpty) {
              if (selected.value == 'Zhejiang') {
                Timer(const Duration(seconds: 1), () {
                  selected.children = [
                    NamedValueOption("杭州市", "Hangzhou"),
                    NamedValueOption("宁波市", "Ningbo"),
                  ];
                });
              }
            }
          },
        ),
        // @DocsDemo
      );
    });

    return ListView(children: [
      const DocTitle("基本用法"),
      VanField(
        label: "地区",
        clickable: true,
        onTap: () => basicShow.value = true,
        arrow: true,
        child: WatchModel(basicValues, (model) {
          return Text(formatValues(kAreaNamedOptions, model.value));
        }),
      ),
      WatchModel(
        basicShow,
        (basicShow) => Popup(
          show: basicShow.value,
          onAfterClose: () => basicShow.value = false,
          position: PopupPosition.bottom,
          round: true,
          child: Cascader(
            title: "请选择地区",
            expands: true,
            onClose: () => basicShow.value = false,
            options: kAreaNamedOptions,
            onCascadeEnd: (v) {
              basicShow.value = false;
              basicValues.value = v;
            },
          ),
        ),
      ),
      const DocTitle("异步加载"),
      VanField(
        label: "地区",
        clickable: true,
        arrow: true,
        onTap: () => asyncShow.value = true,
        child: WatchModel(asyncValues, (model) {
          return WatchModel(asyncValues, (model) {
            return Text(formatValues(asyncOptions.value, model.value));
          });
        }),
      ),
      WatchModel(
        asyncShow,
        (asyncShow) => Popup(
          show: asyncShow.value,
          onAfterClose: () => asyncShow.value = false,
          position: PopupPosition.bottom,
          round: true,
          child: WatchModel(asyncOptions, (mOptions) {
            return Cascader(
              title: "请选择地区",
              expands: true,
              onClose: () => asyncShow.value = false,
              options: mOptions.value,
              onCascadeEnd: (v) {
                asyncShow.value = false;
                asyncValues.value = v;
              },
              onOptionChange: (values, selected) {
                if (selected.children?.isEmpty == true) {
                  if (selected.value == 'Zhejiang') {
                    Timer(const Duration(seconds: 1), () {
                      selected.children = [
                        NamedValueOption("杭州市", "Hangzhou"),
                        NamedValueOption("宁波市", "Ningbo"),
                      ];
                      // refresh options
                      mOptions.value = List.of(mOptions.value);
                    });
                  }
                }
              },
            );
          }),
        ),
      ),
    ]);
  }
}
