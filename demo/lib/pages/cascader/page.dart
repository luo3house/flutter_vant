import 'dart:async';

import 'package:demo/doc/doc_title.dart';
import 'package:demo/widgets/with_value.dart';
import 'package:flutter_vantui/flutter_vantui.dart';
import 'package:flutter/widgets.dart';

class CascaderPage extends StatelessWidget {
  final Uri location;
  const CascaderPage(this.location, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const DocTitle("基本用法"),
      VanCascader(
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
          NamedValueOption("江苏省", "Jiangsu", [
            NamedValueOption("南京市", "Nanjing", [
              NamedValueOption("玄武区", "Xuanwu"),
              NamedValueOption("秦淮区", "Qinhuai"),
            ]),
            NamedValueOption("无锡市", "Wuxi", [
              NamedValueOption("锡山区", "Xishan"),
              NamedValueOption("惠山区", "Huishan"),
            ]),
          ]),
        ],
      ),

      //
      const DocTitle("异步加载"),
      WithModel([
        NamedValueOption("浙江省", "Zhejiang", []),
      ], (mOptions) {
        return WithModel([], (model) {
          return VanCascader(
            options: mOptions.value,
            values: model.value,
            onChange: (values) => model.value = values,
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
        });
      }),
    ]);
  }
}
