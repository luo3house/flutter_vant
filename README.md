## Flutter Vant UI

轻量、快速的 Flutter 端组件，基于 Vant 风格设计。

[![Pub Version](https://img.shields.io/pub/v/flutter_vantui)](https://pub.dev/packages/flutter_vantui)
[![Github Action](https://github.com/luo3house/flutter_vant/actions/workflows/deploy-demo.yaml/badge.svg)](https://luo3house.github.io/flutter_vant/)

## 在线演示

[Live Demo](https://luo3house.github.io/flutter_vant/)

## 特性

- 封装 30+ 常用业务组件，开箱即用
- 从根本出发，无 Material、Cupertino 依赖
- 纯 Dart 实现，无原生代码
- 高度同步 Vant 的设计风格，也可以自定义主题
- 一应俱全，按需引入

## 安装

于 `pubspec.yaml` 添加依赖。

添加 pub.dev 上发布的较稳定版本。

```yaml
dependencies: 
  flutter_vantui: <latest version>
```

或使用 Github 更新较活跃的版本。

```yaml
dependencies:
  flutter_vantui:
    git:
      url: https://github.com/luo3house/flutter_vant.git
      # ref: <branch or commit hash>
```

## 辅助开发

Flutter 使用大量组合对象构建一个渲染盒以提高性能，同时也增加了对应功能的代码量，如果你正在使用快速原型，建议使用类似 Flutter Tailwind 的盒模型辅助开发。如 TailStyle。

在 Flutter Vant UI 里，许多盒模型都通过 TailStyle 创建。

[![Pub Version](https://img.shields.io/pub/v/tailstyle)](https://pub.dev/packages/tailstyle)

![Flutter Logo](images/icon_flutter.png)
![To Plus](images/icon_plus.png)
![TailStyle Logo](images/icon_tailstyle.png)


## License

MIT (c) 2023-present, Luo3House.
