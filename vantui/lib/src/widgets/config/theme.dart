import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable(includeIfNull: false, converters: [ColorJsonConverter()])
class VanTheme {
  static final VanTheme fallback = VanTheme();
  Color gray1 = const Color(0xFFF7F8FA);
  Color gray2 = const Color(0xFFF2F3F5);
  Color gray3 = const Color(0xFFEBEDF0);
  Color gray4 = const Color(0xFFDCDEE0);
  Color gray5 = const Color(0xFFC8C9CC);
  Color gray6 = const Color(0xFF969799);
  Color gray7 = const Color(0xFF646566);
  Color gray8 = const Color(0xFF323233);

  Color white = const Color(0xFFFFFFFF);
  Color red = const Color(0xFFee0a24);
  Color blue = const Color(0xFF1989fa);
  Color orange = const Color(0xFFff976a);
  Color orangeDark = const Color(0xFFed6a0c);
  Color orangeLight = const Color(0xFFfffbe8);
  Color green = const Color(0xFF07c160);

  // Component Colors
  Color primaryColor = const Color(0xFF1989fa);
  Color successColor = const Color(0xFF07c160);
  Color dangerColor = const Color(0xFFee0a24);
  Color warningColor = const Color(0xFFff976a);
  Color textColor = const Color(0xFF323233);
  Color textColor2 = const Color(0xFF969799);
  Color textColor3 = const Color(0xFFC8C9CC);
  Color activeColor = const Color(0xFFf2f3f5);
  double activeOpacity = 0.6;
  double disabledOpacity = 0.5;
  Color background = const Color(0xFFF7F8FA);
  Color background2 = const Color(0xFFFFFFFF);

  // Padding
  double paddingBase = 4;
  double paddingXs = 8;
  double paddingSm = 12;
  double paddingMd = 16;
  double paddingLg = 24;
  double paddingXl = 32;

  // Font
  double fontSizeXs = 10;
  double fontSizeSm = 12;
  double fontSizeMd = 14;
  double fontSizeLg = 16;
  double fontBold = 600;
  double lineHeightXs = 14;
  double lineHeightSm = 18;
  double lineHeightMd = 20;
  double lineHeightLg = 22;

  // Animation
  Duration durationBase = const Duration(milliseconds: 300);
  Duration durationFast = const Duration(milliseconds: 200);

  // Border
  Color borderColor = const Color(0xFFebedf0);
  double borderWidth = 1;
  double radiusSm = 2;
  double radiusMd = 4;
  double radiusLg = 8;
  double radiusMax = 999;

  static fromJson(Map<String, dynamic> json) => _$VanThemeFromJson(json);
  Map<String, dynamic> toJson() => _$VanThemeToJson(this);
}

class ColorJsonConverter extends JsonConverter<Color, String> {
  const ColorJsonConverter() : super();
  @override
  Color fromJson(String json) {
    json = json.padRight(9);
    return Color.fromARGB(
      int.tryParse(json.substring(1, 3)) ?? 0,
      int.tryParse(json.substring(3, 5)) ?? 0,
      int.tryParse(json.substring(5, 7)) ?? 0,
      int.tryParse(json.substring(7, 9)) ?? 0,
    );
  }

  @override
  String toJson(Color object) {
    return [
      '#',
      object.red.toRadixString(16).padLeft(2, "0"),
      object.green.toRadixString(16).padLeft(2, "0"),
      object.blue.toRadixString(16).padLeft(2, "0"),
      object.alpha.toRadixString(16).padLeft(2, "0"),
    ].join('');
  }
}
