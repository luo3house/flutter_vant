# Flutter Vant UI Icons 图标集

[Vant](https://github.com/youzan/vant) 组件库的 Flutter 端图标集。

## 安装图标集

添加 `flutter_vantui_icons` 到 `pubspec.yaml`。

```yaml
flutter_vantui_icons: ^0.0.1
```

## 用法

通过 Icon 绘制，所以可以使用全局配置。

```dart
Icon(VanIcons.star_o);

Icon(VanIcons.star_o, color: Color(0xFFAABBCC));

Icon(VanIcons.star_o, color: Color(0xFFAABBCC), size: 14);
```

全局图标风格配置

```dart
IconTheme(
  data: IconThemeData.fallback().copyWith(size: 14),
  child: Icon(VanIcons.star_o),
)
```
