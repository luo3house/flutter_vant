// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VanTheme _$VanThemeFromJson(Map<String, dynamic> json) => VanTheme()
  ..red = const ColorJsonConverter().fromJson(json['red'] as String)
  ..blue = const ColorJsonConverter().fromJson(json['blue'] as String)
  ..orange = const ColorJsonConverter().fromJson(json['orange'] as String)
  ..orangeDark =
      const ColorJsonConverter().fromJson(json['orangeDark'] as String)
  ..orangeLight =
      const ColorJsonConverter().fromJson(json['orangeLight'] as String)
  ..green = const ColorJsonConverter().fromJson(json['green'] as String)
  ..primaryColor =
      const ColorJsonConverter().fromJson(json['primaryColor'] as String)
  ..successColor =
      const ColorJsonConverter().fromJson(json['successColor'] as String)
  ..dangerColor =
      const ColorJsonConverter().fromJson(json['dangerColor'] as String)
  ..warningColor =
      const ColorJsonConverter().fromJson(json['warningColor'] as String)
  ..textColor = const ColorJsonConverter().fromJson(json['textColor'] as String)
  ..textColor2 =
      const ColorJsonConverter().fromJson(json['textColor2'] as String)
  ..textColor3 =
      const ColorJsonConverter().fromJson(json['textColor3'] as String)
  ..activeColor =
      const ColorJsonConverter().fromJson(json['activeColor'] as String)
  ..activeOpacity = (json['activeOpacity'] as num).toDouble()
  ..disabledOpacity = (json['disabledOpacity'] as num).toDouble()
  ..background =
      const ColorJsonConverter().fromJson(json['background'] as String)
  ..background2 =
      const ColorJsonConverter().fromJson(json['background2'] as String)
  ..paddingBase = (json['paddingBase'] as num).toDouble()
  ..paddingXs = (json['paddingXs'] as num).toDouble()
  ..paddingSm = (json['paddingSm'] as num).toDouble()
  ..paddingMd = (json['paddingMd'] as num).toDouble()
  ..paddingLg = (json['paddingLg'] as num).toDouble()
  ..paddingXl = (json['paddingXl'] as num).toDouble()
  ..fontSizeXs = (json['fontSizeXs'] as num).toDouble()
  ..fontSizeSm = (json['fontSizeSm'] as num).toDouble()
  ..fontSizeMd = (json['fontSizeMd'] as num).toDouble()
  ..fontSizeLg = (json['fontSizeLg'] as num).toDouble()
  ..fontBold = (json['fontBold'] as num).toDouble()
  ..lineHeightXs = (json['lineHeightXs'] as num).toDouble()
  ..lineHeightSm = (json['lineHeightSm'] as num).toDouble()
  ..lineHeightMd = (json['lineHeightMd'] as num).toDouble()
  ..lineHeightLg = (json['lineHeightLg'] as num).toDouble()
  ..durationBase = Duration(microseconds: json['durationBase'] as int)
  ..durationFast = Duration(microseconds: json['durationFast'] as int)
  ..borderColor =
      const ColorJsonConverter().fromJson(json['borderColor'] as String)
  ..borderWidth = (json['borderWidth'] as num).toDouble()
  ..radiusSm = (json['radiusSm'] as num).toDouble()
  ..radiusMd = (json['radiusMd'] as num).toDouble()
  ..radiusLg = (json['radiusLg'] as num).toDouble()
  ..radiusMax = (json['radiusMax'] as num).toDouble();

Map<String, dynamic> _$VanThemeToJson(VanTheme instance) => <String, dynamic>{
      'red': const ColorJsonConverter().toJson(instance.red),
      'blue': const ColorJsonConverter().toJson(instance.blue),
      'orange': const ColorJsonConverter().toJson(instance.orange),
      'orangeDark': const ColorJsonConverter().toJson(instance.orangeDark),
      'orangeLight': const ColorJsonConverter().toJson(instance.orangeLight),
      'green': const ColorJsonConverter().toJson(instance.green),
      'primaryColor': const ColorJsonConverter().toJson(instance.primaryColor),
      'successColor': const ColorJsonConverter().toJson(instance.successColor),
      'dangerColor': const ColorJsonConverter().toJson(instance.dangerColor),
      'warningColor': const ColorJsonConverter().toJson(instance.warningColor),
      'textColor': const ColorJsonConverter().toJson(instance.textColor),
      'textColor2': const ColorJsonConverter().toJson(instance.textColor2),
      'textColor3': const ColorJsonConverter().toJson(instance.textColor3),
      'activeColor': const ColorJsonConverter().toJson(instance.activeColor),
      'activeOpacity': instance.activeOpacity,
      'disabledOpacity': instance.disabledOpacity,
      'background': const ColorJsonConverter().toJson(instance.background),
      'background2': const ColorJsonConverter().toJson(instance.background2),
      'paddingBase': instance.paddingBase,
      'paddingXs': instance.paddingXs,
      'paddingSm': instance.paddingSm,
      'paddingMd': instance.paddingMd,
      'paddingLg': instance.paddingLg,
      'paddingXl': instance.paddingXl,
      'fontSizeXs': instance.fontSizeXs,
      'fontSizeSm': instance.fontSizeSm,
      'fontSizeMd': instance.fontSizeMd,
      'fontSizeLg': instance.fontSizeLg,
      'fontBold': instance.fontBold,
      'lineHeightXs': instance.lineHeightXs,
      'lineHeightSm': instance.lineHeightSm,
      'lineHeightMd': instance.lineHeightMd,
      'lineHeightLg': instance.lineHeightLg,
      'durationBase': instance.durationBase.inMicroseconds,
      'durationFast': instance.durationFast.inMicroseconds,
      'borderColor': const ColorJsonConverter().toJson(instance.borderColor),
      'borderWidth': instance.borderWidth,
      'radiusSm': instance.radiusSm,
      'radiusMd': instance.radiusMd,
      'radiusLg': instance.radiusLg,
      'radiusMax': instance.radiusMax,
    };
