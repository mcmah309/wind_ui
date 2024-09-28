import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

/// The primary color used in the ui.
abstract mixin class Primary {
  Color2 get primary => Colors2.greyNeutral;
}

/// The secondary color used in the ui.
abstract mixin class Secondary {
  Color2 get secondary => Colors2.greyNeutral;
}

/// Backgrounds and large, low-emphasis areas of the screen.
abstract mixin class Surface {
  /// Backgrounds and large, low-emphasis areas of the screen. Usually [shade100] is somehting akin to white.
  Color2 get surface => Colors2.greyNeutral;
}

/// The colors used to communicate basic different types of information.
abstract mixin class CommunicationAccents {
  /// The color used for primary actions that do not have a neutral connotation
  /// e.g. "go to page" is not positive or negative. This can be the primary or secondary color,
  /// but differnet shades will likely be used than the usual uses of primary or secondary.
  Color2 get action => Colors2.greyNeutral;

  /// Attention hightlight like "new feature".
  Color2 get focalPoint => Colors2.greyNeutral;

  /// A destructive action like "delete".
  Color2 get destructive => Colors2.greyNeutral;

  /// A warning like "are you sure you want to do this?".
  Color2 get warning => Colors2.greyNeutral;

  /// A positive action like "saved".
  Color2 get positive => Colors2.greyNeutral;
}

/// Neutral accent color used for low-emphasis areas of the screen. Often shades of grey
abstract mixin class NeutralAccent {
  /// Neutral accent color used for low-emphasis areas of the screen. Often shades of grey
  Color2 get neutral => Colors2.greyNeutral;
}

abstract mixin class TextSelectionAccent {
  Color2 get textSelection => Colors2.greyNeutral;
  Color2 get textSelectionCursor => Colors2.greyNeutral;
}

/// The default decorations. Any variations from the default should probably be made relative to
/// the default e.g.
/// ```dart
///  final differentShadow = shadow + x;
/// ```
// Dev Note: Things like "border color" are not included since they are usally dependent on the colors
// currently being worked with, while something like "shadow color" is usually consistant.
abstract mixin class Decoration {
  Color2 get border => Colors2.greyNeutral;

  /// The radious on the corners of objects.
  ///
  /// A small border radius is pretty neutral, and doesn’t really communicate
  /// much of a personality on its own, while a large border radius starts to feel more playful,
  /// and no border radius at all feels a lot more serious or formal.
  double get borderRadius => 0;

  /// The shadow color.
  Color2 get shadow => Colors2.greyScaleDark;

  /// The radius of the shadow. aka elevation
  double get shadowRadius => 3;
}

abstract mixin class Brightness {
  material.Brightness get brightness => material.Brightness.light;
}

abstract mixin class Font {
  FontSize get textXs => const FontSize(fontSize: 12, height: 16);
  FontSize get textSm => const FontSize(fontSize: 14, height: 20);
  FontSize get textBase => const FontSize(fontSize: 16, height: 24);
  FontSize get textLg => const FontSize(fontSize: 18, height: 28);
  FontSize get textXl => const FontSize(fontSize: 20, height: 28);
  FontSize get text2Xl => const FontSize(fontSize: 24, height: 32);
  FontSize get text3Xl => const FontSize(fontSize: 30, height: 36);
  FontSize get text4Xl => const FontSize(fontSize: 36, height: 40);
  FontSize get text5Xl => const FontSize(fontSize: 48);
  FontSize get text6Xl => const FontSize(fontSize: 60);
  FontSize get text7Xl => const FontSize(fontSize: 72);
  FontSize get text8Xl => const FontSize(fontSize: 96);
  FontSize get text9Xl => const FontSize(fontSize: 128);

  material.FontWeight get fontThin => material.FontWeight.w100;
  material.FontWeight get fontExtraLight => material.FontWeight.w200;
  material.FontWeight get fontLight => material.FontWeight.w300;
  material.FontWeight get fontNormal => material.FontWeight.w400;
  material.FontWeight get fontMedium => material.FontWeight.w500;
  material.FontWeight get fontSemiBold => material.FontWeight.w600;
  material.FontWeight get fontBold => material.FontWeight.w700;
  material.FontWeight get fontExtraBold => material.FontWeight.w800;
  material.FontWeight get fontBlack => material.FontWeight.w900;

  /// Font family
  TextTheme get fontFamily => Typography.blackCupertino;

  Color2 get textOnDark => Colors2.greyScaleLight;
  Color2 get textOnLight => Colors2.greyScaleDark;
}

abstract class FullTheme extends BasicMaterialTheme
    with
        Primary,
        Secondary,
        Surface,
        CommunicationAccents,
        NeutralAccent,
        TextSelectionAccent,
        Decoration,
        Brightness,
        Font {
  @override
  ThemeData createMaterialThemeData() {
    final themeData = super.createMaterialThemeData();
    return themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(shadow: shadow),
        shadowColor: shadow,
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: textSelection,
            selectionHandleColor: textSelectionCursor,
            cursorColor: textSelectionCursor));
  }
}

/// Minimum specification needed to create a material theme
abstract class BasicMaterialTheme
    with Primary, Secondary, Surface, CommunicationAccents, Brightness, Font {
  ThemeData createMaterialThemeData() {
    final bool isDark = brightness == material.Brightness.dark;
    final bool primaryIsDark =
        ThemeData.estimateBrightnessForColor(primary) == material.Brightness.dark;
    final bool secondaryIsDark =
        ThemeData.estimateBrightnessForColor(secondary) == material.Brightness.dark;

    final colorScheme = ColorScheme(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: destructive,
      onPrimary: primaryIsDark ? Colors.white : Colors.black,
      onSecondary: secondaryIsDark ? Colors.white : Colors.black,
      onSurface: isDark ? Colors.white : Colors.black,
      onError: isDark ? Colors.black : Colors.white,
      brightness: brightness,
    );

    return ThemeData.from(colorScheme: colorScheme, textTheme: fontFamily, useMaterial3: true);
  }
}

/// A redesigned version of the [MaterialColor] and [MaterialAccentColor] classes.
// Dev Note: Cannot implement [MaterialColor] and [MaterialAccentColor] since each expects a different color (500 and 200) to be the primarys according to the doc.
abstract class Color2 extends MaterialColor {
  /// The label for this color e.g. "background" or "primary"
  final String? label;

  /// Light shade. Equivlent to [shade100]
  HSLColor get shade100Hsl;

  /// Medium light shade. Equivlent to [shade300]
  HSLColor get shade300Hsl;

  /// Medium shade. Equivlent to [shade500]
  HSLColor get shade500Hsl;

  /// Medium dark shade. Equivlent to [shade700]
  HSLColor get shade700Hsl;

  /// Dark shade. Equivlent to [shade900]
  HSLColor get shade900Hsl;

  // ignore: prefer_const_constructors_in_immutables
  Color2(super.primary, super.swatch, {this.label});

  factory Color2.explict(
      {required HSLColor shade100,
      required HSLColor shade300,
      required HSLColor shade500,
      required HSLColor shade700,
      required HSLColor shade900,
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

  factory Color2.material(MaterialColor material) {
    return material.toColor2();
  }

  factory Color2.color(Color color) {
    final material = MaterialColor2(color.value, {
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color
    });
    return Color2.material(material);
  }

  /// Convert this color to a [MaterialAccentColor]
  MaterialAccentColor toMaterialAccentColor() {
    final swatch = {100: shade100, 200: shade200, 400: shade300, 700: shade700};

    return MaterialAccentColor(shade200.value, swatch);
  }

  @override
  bool operator ==(Object other) {
    if (other is Color2) {
      return shade100Hsl == other.shade100Hsl &&
          shade300Hsl == other.shade300Hsl &&
          shade500Hsl == other.shade500Hsl &&
          shade700Hsl == other.shade700Hsl &&
          shade900Hsl == other.shade900Hsl;
    }
    return false;
  }

  @override
  int get hashCode {
    return shade100Hsl.hashCode ^
        shade300Hsl.hashCode ^
        shade500Hsl.hashCode ^
        shade700Hsl.hashCode ^
        shade900Hsl.hashCode;
  }

  @override
  String toString() {
    return label == null ? "Color2" : "Color2(\"$label\")";
  }
}

class ExplictColor2 extends Color2 {
  @override
  final HSLColor shade100Hsl;
  @override
  final HSLColor shade300Hsl;
  @override
  final HSLColor shade500Hsl;
  @override
  final HSLColor shade700Hsl;
  @override
  final HSLColor shade900Hsl;

  factory ExplictColor2({
    required HSLColor shade100,
    required HSLColor shade300,
    required HSLColor shade500,
    required HSLColor shade700,
    required HSLColor shade900,
    String? label,
  }) {
    final mediumColor = shade500.toColor();
    final swatch = {
      50: linearlyInterpolate(HSLColor.fromColor(Colors.white), shade100, 0.5).toColor(),
      100: shade100.toColor(),
      200: linearlyInterpolate(shade100, shade300, 0.5).toColor(),
      300: shade300.toColor(),
      400: linearlyInterpolate(shade300, shade500, 0.5).toColor(),
      500: mediumColor,
      600: linearlyInterpolate(shade500, shade700, 0.5).toColor(),
      700: shade700.toColor(),
      800: linearlyInterpolate(shade700, shade900, 0.5).toColor(),
      900: shade900.toColor()
    };
    return ExplictColor2._(mediumColor.value, swatch,
        shade100Hsl: shade100,
        shade300Hsl: shade300,
        shade500Hsl: shade500,
        shade700Hsl: shade700,
        shade900Hsl: shade900,
        label: label);
  }

  ExplictColor2._(super.primary, super.swatch,
      {required this.shade100Hsl,
      required this.shade300Hsl,
      required this.shade500Hsl,
      required this.shade700Hsl,
      required this.shade900Hsl,
      super.label});
}

class ShadeColor2 extends Color2 {
  final double hue;
  final SL lightestShade;
  final SL darkestShade;
  final InterpolationFunction interpolate;

  @override
  final HSLColor shade100Hsl;
  @override
  final HSLColor shade300Hsl;
  @override
  final HSLColor shade500Hsl;
  @override
  final HSLColor shade700Hsl;
  @override
  final HSLColor shade900Hsl;

  factory ShadeColor2(
      {required double hue,
      required SL lightestShade,
      required SL darkestShade,
      InterpolationFunction interpolate = linearlyInterpolate,
      String? label}) {
    final shade100Hsl =
        HSLColor.fromAHSL(1, hue, lightestShade.saturation, lightestShade.lightness);
    final shade900Hsl = HSLColor.fromAHSL(1, hue, darkestShade.saturation, darkestShade.lightness);

    final shade300Hsl = interpolate(shade100Hsl, shade900Hsl, 0.25);
    final shade500Hsl = interpolate(shade100Hsl, shade900Hsl, 0.5);
    final shade700Hsl = interpolate(shade100Hsl, shade900Hsl, 0.75);

    const end = 900;
    const start = 100;
    const range = end - start;
    double t(int val) {
      return (val - start) / range;
    }

    assert(t(300) == 0.25 && t(500) == 0.5 && t(700) == 0.75, "You did your math wrong buddy.");

    final shade500 = shade500Hsl.toColor();
    final swatch = {
      50: interpolate(HSLColor.fromColor(Colors.white), shade100Hsl, 0.5).toColor(),
      100: shade100Hsl.toColor(),
      200: interpolate(shade100Hsl, shade900Hsl, t(200)).toColor(),
      300: shade300Hsl.toColor(),
      400: interpolate(shade100Hsl, shade900Hsl, t(400)).toColor(),
      500: shade500,
      600: interpolate(shade100Hsl, shade900Hsl, t(600)).toColor(),
      700: shade700Hsl.toColor(),
      800: interpolate(shade100Hsl, shade900Hsl, t(800)).toColor(),
      900: shade900Hsl.toColor()
    };

    return ShadeColor2._(shade500.value, swatch,
        hue: hue,
        lightestShade: lightestShade,
        darkestShade: darkestShade,
        interpolate: interpolate,
        label: label,
        shade100Hsl: shade100Hsl,
        shade300Hsl: shade300Hsl,
        shade500Hsl: shade500Hsl,
        shade700Hsl: shade700Hsl,
        shade900Hsl: shade900Hsl);
  }

  factory ShadeColor2.greyScale(
      {required double startLightness,
      required double endLightness,
      InterpolationFunction interpolate = linearlyInterpolate,
      String? label}) {
    return ShadeColor2(
        hue: 0,
        lightestShade: SL(saturation: 0, lightness: startLightness),
        darkestShade: SL(saturation: 0, lightness: endLightness),
        interpolate: interpolate,
        label: label);
  }

  ShadeColor2._(super.primary, super.swatch,
      {required this.hue,
      required this.lightestShade,
      required this.darkestShade,
      required this.shade100Hsl,
      required this.shade300Hsl,
      required this.shade500Hsl,
      required this.shade700Hsl,
      required this.shade900Hsl,
      this.interpolate = linearlyInterpolate,
      super.label});
}

class MaterialColor2 extends Color2 {
  MaterialColor2(super.primary, super.swatch, {super.label});

  @override
  HSLColor get shade100Hsl => HSLColor.fromColor(shade100);
  @override
  HSLColor get shade300Hsl => HSLColor.fromColor(shade300);
  @override
  HSLColor get shade500Hsl => HSLColor.fromColor(shade500);
  @override
  HSLColor get shade700Hsl => HSLColor.fromColor(shade700);
  @override
  HSLColor get shade900Hsl => HSLColor.fromColor(shade900);
}

//************************************************************************//

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

class Colors2 {
  static final Color2 greyNeutral = ExplictColor2(
      shade100: const HSLColor.fromAHSL(1, 0, 0, 0.88),
      shade300: const HSLColor.fromAHSL(1, 0, 0, 0.76),
      shade500: const HSLColor.fromAHSL(1, 0, 0, 0.58),
      shade700: const HSLColor.fromAHSL(1, 0, 0, 0.43),
      shade900: const HSLColor.fromAHSL(1, 0, 0, 0.28));

  static final Color2 greyCool = ExplictColor2(
      shade100: const HSLColor.fromAHSL(1, 208, 0.21, 0.88),
      shade300: const HSLColor.fromAHSL(1, 210, 0.16, 0.76),
      shade500: const HSLColor.fromAHSL(1, 208, 0.12, 0.58),
      shade700: const HSLColor.fromAHSL(1, 207, 0.12, 0.43),
      shade900: const HSLColor.fromAHSL(1, 209, 0.15, 0.28));

  static final Color2 greyWarm = ExplictColor2(
      shade100: const HSLColor.fromAHSL(1, 39, 0.21, 0.88),
      shade300: const HSLColor.fromAHSL(1, 39, 0.16, 0.76),
      shade500: const HSLColor.fromAHSL(1, 39, 0.12, 0.58),
      shade700: const HSLColor.fromAHSL(1, 40, 0.12, 0.43),
      shade900: const HSLColor.fromAHSL(1, 41, 0.15, 0.28));

  static final Color2 greyScaleLight = ShadeColor2.greyScale(startLightness: 0, endLightness: 0.5);
  static final Color2 greyScaleDark = ShadeColor2.greyScale(startLightness: 0.5, endLightness: 1);
}

class FontSize extends TextStyle {
  @override
  double get fontSize => super.fontSize!;

  const FontSize({required double fontSize, super.height}) : super(fontSize: fontSize);
}

//************************************************************************//

extension Color2OnMaterialColor on MaterialColor {
  Color2 toColor2() {
    return MaterialColor2(value, {
      50: this[50]!,
      100: this[100]!,
      200: this[200]!,
      300: this[300]!,
      400: this[400]!,
      500: this[500]!,
      600: this[600]!,
      700: this[700]!,
      800: this[800]!,
      900: this[900]!
    });
  }
}

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
