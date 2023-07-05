# 开始使用

## 安装 Flutter Vant UI

在 Flutter 项目 `pubspec.yaml` 文件配置依赖。

Flutter Vant UI 会发布到 Github 和 pub.dev。发布到 pub.dev 为稳定版本，而 Github 会更频繁更新。

- 从 pub.dev 安装更稳定版本

```yaml
dependencies: 
  flutter_vantui: <latest version>
```

- 从 Github 安装活跃更新的版本

```yaml
dependencies:
  flutter_vantui:
    git:
      url: https://github.com/luo3house/flutter_vant.git
      # ref: <branch or commit hash>
```

配置后，使用 `flutter pub get` 安装依赖，即可使用 Flutter Vant UI 的组件。


## 引入组件

```dart
import "package:flutter_vantui/flutter_vantui.dart";
```

::: tip
当 Material 项目与 Flutter Vant 组件库混用时，可能会出现组件命名冲突，需要手动隐藏有冲突的组件。

```dart
import "package:flutter_vantui/flutter_vantui.dart";
import "package:flutter/material.dart" hide Tab;

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tab(); // Flutter Vant UI: Tab
  }
}
```
:::
