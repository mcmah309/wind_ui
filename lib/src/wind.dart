import 'package:flutter/material.dart';

abstract class Primary {
  Color2 get primary;
}

abstract class CommunicationAccents {
  /// Attention hightlight like "new feature".
  Color2 get focalPoint;

  /// A destructive actoin like "delete".
  Color2 get destructive;

  /// A warning like "are you sure you want to do this?".
  Color2 get warning;

  /// A positive action like "saved".
  Color2 get positive;
}

class AppTheme2 implements Primary, CommunicationAccents {
  @override
  final Color2 primary;

  /// A
  late final MaterialColor neutral;

  @override
  final Color2 focalPoint;
  @override
  final Color2 destructive;
  @override
  final Color2 warning;
  @override
  final Color2 positive;

  AppTheme2(
      {required this.primary,
      required this.focalPoint,
      required this.destructive,
      required this.warning,
      required this.positive});
}

enum Shade {
  light(100),
  mediumLight(300),
  medium(500),
  mediumDark(700),
  dark(900);

  final int value;

  const Shade(this.value);
}

/// A redesigned version of the [MaterialColor] and [MaterialAccentColor] classes.
// Dev Note: Cannot implement [MaterialColor] and [MaterialAccentColor] since each expects a different color (500 and 200) to be the primarys according to the doc.
abstract class Color2 extends MaterialColor {
  /// The label for this color e.g. "background" or "primary"
  String? get label;

  /// Equivlent to [shade100]
  HSLColor get light;

  /// Equivlent to [shade300]
  HSLColor get mediumLight;

  /// Equivlent to [shade500]
  HSLColor get medium;

  /// Equivlent to [shade700]
  HSLColor get mediumDark;

  /// Equivlent to [shade900]
  HSLColor get dark;

  // ignore: prefer_const_constructors_in_immutables
  Color2(super.primary, super.swatch);

  factory Color2.explict(
      {required HSLColor light,
      required HSLColor mediumLight,
      required HSLColor medium,
      required HSLColor mediumDark,
      required HSLColor dark,
      String? label}) = ExplictColor2;

  factory Color2.shade(
      {required double hue,
      required SL lightestShade,
      required SL darkestShade,
      InterpolationFunction interpolate = linearlyInterpolate,
      String? label}) {
    return ShadeColor2(
        hue: hue,
        lightestShade: lightestShade,
        darkestShade: darkestShade,
        interpolate: interpolate,
        label: label);
  }

  /// Convert this color to a [MaterialAccentColor]
  MaterialAccentColor toMaterialAccentColor() {
    final swatch = {100: shade100, 200: shade200, 400: shade300, 700: shade700};

    return MaterialAccentColor(shade200.value, swatch);
  }

  @override
  bool operator ==(Object other) {
    if (other is Color2) {
      return light == other.light &&
          mediumLight == other.mediumLight &&
          medium == other.medium &&
          mediumDark == other.mediumDark &&
          dark == other.dark;
    }
    return false;
  }

  @override
  int get hashCode {
    return light.hashCode ^
        mediumLight.hashCode ^
        medium.hashCode ^
        mediumDark.hashCode ^
        dark.hashCode;
  }

  @override
  String toString() {
    return label == null ? "Color2" : "Color2(\"$label\")";
  }
}

class ExplictColor2 extends Color2 {
  @override
  final String? label;
  @override
  final HSLColor light;
  @override
  final HSLColor mediumLight;
  @override
  final HSLColor medium;
  @override
  final HSLColor mediumDark;
  @override
  final HSLColor dark;

  factory ExplictColor2({
    required HSLColor light,
    required HSLColor mediumLight,
    required HSLColor medium,
    required HSLColor mediumDark,
    required HSLColor dark,
    String? label,
  }) {
    final mediumColor = medium.toColor();
    final swatch = {
      50: linearlyInterpolate(HSLColor.fromColor(Colors.white), light, 0.5).toColor(),
      100: light.toColor(),
      200: linearlyInterpolate(light, mediumLight, 0.5).toColor(),
      300: mediumLight.toColor(),
      400: linearlyInterpolate(mediumLight, medium, 0.5).toColor(),
      500: mediumColor,
      600: linearlyInterpolate(medium, mediumDark, 0.5).toColor(),
      700: mediumDark.toColor(),
      800: linearlyInterpolate(mediumDark, dark, 0.5).toColor(),
      900: dark.toColor()
    };
    return ExplictColor2._(mediumColor.value, swatch,
        light: light,
        mediumLight: mediumLight,
        medium: medium,
        mediumDark: mediumDark,
        dark: dark,
        label: label);
  }

  ExplictColor2._(super.primary, super.swatch,
      {required this.light,
      required this.mediumLight,
      required this.medium,
      required this.mediumDark,
      required this.dark,
      this.label});
}

class ShadeColor2 extends Color2 {
  @override
  final String? label;
  final double hue;
  final SL lightestShade;
  final SL darkestShade;
  final InterpolationFunction interpolate;

  @override
  late final HSLColor light;
  @override
  late final HSLColor mediumLight;
  @override
  late final HSLColor medium;
  @override
  late final HSLColor mediumDark;
  @override
  late final HSLColor dark;

  factory ShadeColor2(
      {required double hue,
      required SL lightestShade,
      required SL darkestShade,
      InterpolationFunction interpolate = linearlyInterpolate,
      String? label}) {
    final light = HSLColor.fromAHSL(1, hue, lightestShade.saturation, lightestShade.lightness);
    final dark = HSLColor.fromAHSL(1, hue, darkestShade.saturation, darkestShade.lightness);

    final mediumLight = interpolate(light, dark, 0.25);
    final medium = interpolate(light, dark, 0.5);
    final mediumDark = interpolate(light, dark, 0.75);

    const end = 900;
    const start = 100;
    const range = end - start;
    double t(int val) {
      return (val - start) / range;
    }

    assert(t(300) == 0.25 && t(500) == 0.5 && t(700) == 0.75, "You did your math wrong buddy.");

    final mediumColor = medium.toColor();
    final swatch = {
      50: interpolate(HSLColor.fromColor(Colors.white), light, 0.5).toColor(),
      100: light.toColor(),
      200: interpolate(light, dark, t(200)).toColor(),
      300: mediumLight.toColor(),
      400: interpolate(light, dark, t(400)).toColor(),
      500: mediumColor,
      600: interpolate(light, dark, t(600)).toColor(),
      700: mediumDark.toColor(),
      800: interpolate(light, dark, t(800)).toColor(),
      900: dark.toColor()
    };

    return ShadeColor2._(mediumColor.value, swatch,
        hue: hue,
        lightestShade: lightestShade,
        darkestShade: darkestShade,
        interpolate: interpolate,
        label: label);
  }

  ShadeColor2._(super.primary, super.swatch,
      {required this.hue,
      required this.lightestShade,
      required this.darkestShade,
      this.interpolate = linearlyInterpolate,
      this.label});
}

/// A shade of a color defined by its saturation and lightness (The "SL" in "HSL").
class SL {
  final double saturation;
  final double lightness;

  SL({required this.saturation, required this.lightness});
}

/// A function that interpolates between two [HSLColor]s. Where `t` is a value between 0.0 and 1.0.
/// 0.0 means the color is `from`, 1.0 means the color is `to`.
typedef InterpolationFunction = HSLColor Function(HSLColor from, HSLColor to, double t);

HSLColor linearlyInterpolate(HSLColor from, HSLColor to, double t) {
  return HSLColor.lerp(from, to, t)!;
}

//************************************************************************//

class Colors2 {
  static final Color2 greyNeutral = ExplictColor2(
      light: HSLColor.fromAHSL(1, 0, 0, 0.88),
      mediumLight: HSLColor.fromAHSL(1, 0, 0, 0.76),
      medium: HSLColor.fromAHSL(1, 0, 0, 0.58),
      mediumDark: HSLColor.fromAHSL(1, 0, 0, 0.43),
      dark: HSLColor.fromAHSL(1, 0, 0, 0.28));

  static final Color2 greyCool = ExplictColor2(
      light: HSLColor.fromAHSL(1, 208, 0.21, 0.88),
      mediumLight: HSLColor.fromAHSL(1, 210, 0.16, 0.76),
      medium: HSLColor.fromAHSL(1, 208, 0.12, 0.58),
      mediumDark: HSLColor.fromAHSL(1, 207, 0.12, 0.43),
      dark: HSLColor.fromAHSL(1, 209, 0.15, 0.28));

  static final Color2 greyWarm = ExplictColor2(
      light: HSLColor.fromAHSL(1, 39, 0.21, 0.88),
      mediumLight: HSLColor.fromAHSL(1, 39, 0.16, 0.76),
      medium: HSLColor.fromAHSL(1, 39, 0.12, 0.58),
      mediumDark: HSLColor.fromAHSL(1, 40, 0.12, 0.43),
      dark: HSLColor.fromAHSL(1, 41, 0.15, 0.28));
}

//************************************************************************//

extension HSLColorExtension on HSLColor {
  /// Increase the brightness of the color by rotating the hue towards the closest max brightness hue.
  /// [percent] is a value between 0.0 and 1.0.
  /// Based on: pg 135 of "refactor ui" by Adam Watham & Steve Schoger
  HSLColor increaseBrightnessByRotatingHue(HSLColor color, double percent) {
    assert(percent >= 0 && percent <= 1);
    double hue = color.hue;
    int closest = _maxsHues.first;
    for (final maxHue in _maxsHues.skip(1)) {
      if ((hue - maxHue).abs() < (hue - closest).abs()) {
        closest = maxHue;
      }
    }
    hue += (closest - hue) * percent;
    return HSLColor.fromAHSL(color.alpha, hue, color.saturation, color.lightness);
  }

  /// Decrease the brightness of the color by rotating the hue towards the closest min brightness hue.
  /// [percent] is a value between 0.0 and 1.0.
  /// Based on: pg 135 of "refactor ui" by Adam Watham & Steve Schoger
  HSLColor decreaseBrightnessByRotatingHue(HSLColor color, double percent) {
    assert(percent >= 0 && percent <= 1);
    double hue = color.hue;
    int closest = _minHues.first;
    for (final minHue in _minHues.skip(1)) {
      if ((hue - minHue).abs() < (hue - closest).abs()) {
        closest = minHue;
      }
    }
    hue += (closest - hue) * percent;
    return HSLColor.fromAHSL(color.alpha, hue, color.saturation, color.lightness);
  }
}

/// hue to precieved brightness value, when saturation is 100% and luminosity is 50%.
/// Following sqrt( 0.299*R^2 + 0.587*G^2 + 0.114*B^2 ) / 255 . Source: https://stackoverflow.com/a/596243/11839191
/// ```dart
/// double precievedBrightness(Color color) {
///   return math.sqrt(0.299 * (color.red ^ 2) + 0.587 * (color.green ^ 2) + 0.114 * (color.blue ^ 2)) / 255;
/// }
/// ```
/// Also referrenced by pg 135 of "refactor ui" by Adam Watham & Steve Schoger
// ignore: unused_element
const Map<int, double> _precievedBrightnessMap = {
  0: 0.5468089246, // min
  30: 0.6685082178,
  60: 0.9412757301, // max
  90: 0.8138411541,
  120: 0.7661592524, // min
  150: 0.7846808063,
  180: 0.8372574276, // max
  210: 0.5117648261,
  240: 0.3376388603, // min
  270: 0.4351292039,
  300: 0.6426507605, // max
  330: 0.5724718052
};

const List<int> _maxsHues = [60, 180, 300];
const List<int> _minHues = [0, 120, 240];
