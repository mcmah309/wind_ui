import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:meta/meta.dart';

/// The primary color used in the ui.
abstract mixin class Primary {
  @mustBeOverridden
  Color2 get primary => Colors2.greyNeutral;
}

/// The secondary color used in the ui.
abstract mixin class Secondary {
  @mustBeOverridden
  Color2 get secondary => Colors2.greyNeutral;
}

/// Backgrounds and large, low-emphasis areas of the screen.
abstract mixin class Surface {
  /// Backgrounds and large, low-emphasis areas of the screen. Usually [shade100] is somehting akin to white.
  @mustBeOverridden
  Color2 get surface => Colors2.greyNeutral;
}

/// The colors used to communicate basic different types of information.
abstract mixin class CommunicationAccents {
  /// The color used for primary actions that do not have a neutral connotation
  /// e.g. "go to page" is not positive or negative. This can be the primary or secondary color,
  /// but differnet shades will likely be used than the usual uses of primary or secondary.
  @mustBeOverridden
  Color2 get action => Colors2.greyNeutral;

  /// Attention hightlight like "new feature".
  @mustBeOverridden
  Color2 get focalPoint => Colors2.greyNeutral;

  /// A destructive action like "delete".
  @mustBeOverridden
  Color2 get destructive => Colors2.greyNeutral;

  /// A warning like "are you sure you want to do this?".
  @mustBeOverridden
  Color2 get warning => Colors2.greyNeutral;

  /// A positive action like "saved".
  @mustBeOverridden
  Color2 get positive => Colors2.greyNeutral;
}

/// Neutral accent color used for low-emphasis areas of the screen. Often shades of grey
abstract mixin class NeutralAccent {
  /// Neutral accent color used for low-emphasis areas of the screen. Often shades of grey
  Color2 get neutral => Colors2.greyNeutral;
}

abstract mixin class TextSelectionAccent {
  @mustBeOverridden
  Color2 get textSelection => Colors2.greyCool;
  @mustBeOverridden
  Color2 get textSelectionCursor => Colors2.greyCool;
}

/// The default decorations. Any variations from the default should probably be made relative to
/// the default e.g.
/// ```dart
///  final differentShadow = shadow + x;
/// ```
// Dev Note: Things like "border color" are not included since they are usally dependent on the colors
// currently being worked with, while something like "shadow color" is usually consistant.
abstract mixin class Decoration {
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
  FontSize get textXs => const FontSize(fontSize: 12, height: 1 + 1 / 3);
  FontSize get textSm => const FontSize(fontSize: 14, height: 1 + 3 / 7);
  FontSize get textBase => const FontSize(fontSize: 16, height: 1.25);
  FontSize get textLg => const FontSize(fontSize: 18, height: 1 + 5 / 9);
  FontSize get textXl => const FontSize(fontSize: 20, height: 1.4);
  FontSize get text2Xl => const FontSize(fontSize: 24, height: 1 + 1 / 3);
  FontSize get text3Xl => const FontSize(fontSize: 30, height: 1.2);
  FontSize get text4Xl => const FontSize(fontSize: 36, height: 1 + 1 / 9);
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

  /// For on dark backgrounds
  Color2 get textLight => Colors2.greyScaleLight;

  /// For on light backgrounds
  Color2 get textDark => Colors2.greyScaleDark;
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

/// Given linear position `t` between 0.0 and 1.0 (The two shades),
/// return the new `t`. e.g. [Curves.linear] return an unmodified `t`.
/// Other useful curves:
/// - [Curves.easeInOutCubic] : Slow transition on the ends, Fast in the middle
/// - [Curves.slowMiddle] : Fast on the ends, Slow transition for middle
/// - [Curves.easeInCubic] : Slow at start, Fast at end
/// - [Curves.easeOutCubic] : Fast at start, Slow at end
/// All curves: https://api.flutter.dev/flutter/animation/Curves-class.html
typedef Curve = ParametricCurve<double>;

/// A redesigned version of the [MaterialColor] and [MaterialAccentColor] classes.
// Dev Note: Cannot implement [MaterialColor] and [MaterialAccentColor] since each expects a different color (500 and 200) to be the primarys according to the doc.
class Color2 extends MaterialColor {
  /// The label for this color e.g. "background" or "primary"
  final String? label;

  /// The shade a quater the way between the lightest shade ([shade900]) and white.
  @override
  Color get shade50 => this[50]!;

  /// The lightest shade.
  @override
  Color get shade100 => this[100]!;

  /// The second lightest shade.
  @override
  Color get shade200 => this[200]!;

  /// The third lightest shade.
  @override
  Color get shade300 => this[300]!;

  /// The fourth lightest shade.
  @override
  Color get shade400 => this[400]!;

  /// The default shade.
  @override
  Color get shade500 => this[500]!;

  /// The fourth darkest shade.
  @override
  Color get shade600 => this[600]!;

  /// The third darkest shade.
  @override
  Color get shade700 => this[700]!;

  /// The second darkest shade.
  @override
  Color get shade800 => this[800]!;

  /// The darkest shade.
  @override
  Color get shade900 => this[900]!;

  /// The shade quater between the darkest shade ([shade900]) and black.
  Color get shade950 => this[950]!;

  /// Equivalent to [shade50]
  HSLColor get shade50Hsl => HSLColor.fromColor(shade50);

  /// Light shade. Equivalent to [shade100]
  HSLColor get shade100Hsl => HSLColor.fromColor(shade100);

  /// Equivalent to [shade200]
  HSLColor get shade200Hsl => HSLColor.fromColor(shade200);

  /// Medium light shade. Equivalent to [shade300]
  HSLColor get shade300Hsl => HSLColor.fromColor(shade300);

  /// Equivalent to [shade400]
  HSLColor get shade400Hsl => HSLColor.fromColor(shade400);

  /// Medium shade. Equivalent to [shade500]
  HSLColor get shade500Hsl => HSLColor.fromColor(shade500);

  /// Equivalent to [shade600]
  HSLColor get shade600Hsl => HSLColor.fromColor(shade600);

  /// Medium dark shade. Equivalent to [shade700]
  HSLColor get shade700Hsl => HSLColor.fromColor(shade700);

  /// Equivalent to [shade800]
  HSLColor get shade800Hsl => HSLColor.fromColor(shade800);

  /// Dark shade. Equivalent to [shade900]
  HSLColor get shade900Hsl => HSLColor.fromColor(shade900);

  /// Equivalent to [shade950]
  HSLColor get shade950Hsl => HSLColor.fromColor(shade950);

  // ignore: prefer_const_constructors_in_immutables
  Color2(super.primary, super.swatch, {this.label});

  /// Explicitly provided color shades. No interpolation is done
  factory Color2.explicit({
    required Color shade50,
    required Color shade100,
    required Color shade200,
    required Color shade300,
    required Color shade400,
    required Color shade500,
    required Color shade600,
    required Color shade700,
    required Color shade800,
    required Color shade900,
    required Color shade950,
  }) {
    final Map<int, Color> swatch = {
      50: shade50,
      100: shade100,
      200: shade200,
      300: shade300,
      400: shade400,
      500: shade500,
      600: shade600,
      700: shade700,
      800: shade800,
      900: shade900,
      950: shade950
    };
    return Color2._(shade500.value, swatch);
  }

  /// Implicitly provided color shades. Automatically filling any missing shades by interpolating between
  /// the provided shades.
  factory Color2.implicit(
      {HSLColor? shade50,
      required HSLColor shade100,
      HSLColor? shade200,
      HSLColor? shade300,
      HSLColor? shade400,
      HSLColor? shade500,
      HSLColor? shade600,
      HSLColor? shade700,
      HSLColor? shade800,
      required HSLColor shade900,
      HSLColor? shade950,
      Curve alphaCurve = Curves.linear,
      Curve hueCurve = Curves.linear,
      Curve saturationCurve = Curves.linear,
      Curve lightnessCurve = Curves.linear,
      String? label}) {
    List<HSLColor?> colors = [
      shade100,
      shade200,
      shade300,
      shade400,
      shade500,
      shade600,
      shade700,
      shade800,
      shade900
    ];
    HSLColor calculateShade(List<HSLColor?> colors, int index) {
      assert(colors.first != null &&
          colors.last != null &&
          colors.length > 1 &&
          index != 0 &&
          index != colors.length - 1 &&
          colors[index] == null);
      final int lastIndex = index - 1;
      HSLColor lastColor = colors[lastIndex]!;
      HSLColor? nextColor;
      int nextColorIndex = 0;
      for (int i = index + 1; i < colors.length; i++) {
        final color = colors[i];
        if (color != null) {
          nextColor = color;
          nextColorIndex = i;
          break;
        }
      }
      double t = 1 / (nextColorIndex - lastIndex);
      assert(t < 1 && t > 0);
      return _interpolate(
          from: lastColor,
          to: nextColor!,
          tAlpha: alphaCurve.transform(t),
          tHue: hueCurve.transform(t),
          tSaturation: saturationCurve.transform(t),
          tLightness: lightnessCurve.transform(t));
    }

    for (int index = 0; index < colors.length; index++) {
      if (colors[index] == null) {
        colors[index] = calculateShade(colors, index);
      }
    }
    List<HSLColor> colorsC = colors.cast<HSLColor>();

    final medium = colorsC[4].toColor();
    final Map<int, Color> swatch = {
      50: shade50?.toColor() ??
          _interpolate(
                  from: HSLColor.fromAHSL(shade100.alpha, shade100.hue, shade100.saturation, 1),
                  to: shade100,
                  tAlpha: 0.25,
                  tHue: 0.25,
                  tSaturation: 0.25,
                  tLightness: 0.25)
              .toColor(),
      100: shade100.toColor(),
      200: colorsC[1].toColor(),
      300: colorsC[2].toColor(),
      400: colorsC[3].toColor(),
      500: medium,
      600: colorsC[5].toColor(),
      700: colorsC[6].toColor(),
      800: colorsC[7].toColor(),
      900: shade900.toColor(),
      950: shade950?.toColor() ??
          _interpolate(
                  from: shade900,
                  to: HSLColor.fromAHSL(shade900.alpha, shade900.hue, shade900.saturation, 0),
                  tAlpha: 0.25,
                  tHue: 0.25,
                  tSaturation: 0.25,
                  tLightness: 0.25)
              .toColor()
    };
    return Color2._(medium.value, swatch, label: label);
  }

  /// A color palet defined by transitioning between two shades of a hue.
  factory Color2.shade(
      {required double hue,
      SL lightestShade = const SL(saturation: 1, lightness: 1),
      SL darkestShade = const SL(saturation: 1, lightness: 0),
      Curve alphaCurve = Curves.linear,
      Curve saturationCurve = Curves.linear,
      Curve lightnessCurve = Curves.linear,
      String? label}) {
    final shade100Hsl = HSLColor.fromAHSL(
        lightestShade.alpha, hue, lightestShade.saturation, lightestShade.lightness);
    final shade900Hsl =
        HSLColor.fromAHSL(darkestShade.alpha, hue, darkestShade.saturation, darkestShade.lightness);

    const end = 900;
    const start = 100;
    const range = end - start;
    double t(int val) {
      return (val - start) / range;
    }

    assert(t(300) == 0.25 && t(500) == 0.5 && t(700) == 0.75, "You did your math wrong buddy.");

    double tVal = t(200);
    final shade200Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    tVal = t(300);
    final shade300Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    tVal = t(400);
    final shade400Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    tVal = t(500);
    final shade500Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    final shade500 = shade500Hsl.toColor();

    tVal = t(600);
    final shade600Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    tVal = t(700);
    final shade700Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    tVal = t(800);
    final shade800Hsl = _interpolate(
        from: shade100Hsl,
        to: shade900Hsl,
        tAlpha: alphaCurve.transform(tVal),
        tHue: tVal,
        tSaturation: saturationCurve.transform(tVal),
        tLightness: lightnessCurve.transform(tVal));

    final swatch = {
      50: _interpolate(
              from:
                  HSLColor.fromAHSL(shade100Hsl.alpha, shade100Hsl.hue, shade100Hsl.saturation, 1),
              to: shade100Hsl,
              tAlpha: 0.25,
              tHue: 0.25,
              tSaturation: 0.25,
              tLightness: 0.25)
          .toColor(),
      100: shade100Hsl.toColor(),
      200: shade200Hsl.toColor(),
      300: shade300Hsl.toColor(),
      400: shade400Hsl.toColor(),
      500: shade500,
      600: shade600Hsl.toColor(),
      700: shade700Hsl.toColor(),
      800: shade800Hsl.toColor(),
      900: shade900Hsl.toColor(),
      950: _interpolate(
              from: shade900Hsl,
              to: HSLColor.fromAHSL(shade100Hsl.alpha, shade100Hsl.hue, shade100Hsl.saturation, 0),
              tAlpha: 0.25,
              tHue: 0.25,
              tSaturation: 0.25,
              tLightness: 0.25)
          .toColor()
    };

    return Color2._(shade500.value, swatch, label: label);
  }

  /// A grey scale color defined by interpolating between two lightness values in the gray scale.
  factory Color2.greyScale(
      {required double startLightness,
      required double endLightness,
      Curve alphaCurve = Curves.linear,
      Curve saturationCurve = Curves.linear,
      Curve lightnessCurve = Curves.linear,
      double startAlpha = 1,
      double endAlpha = 1,
      String? label}) {
    return Color2.shade(
        hue: 0,
        lightestShade: SL(saturation: 0, lightness: startLightness, alpha: startAlpha),
        darkestShade: SL(saturation: 0, lightness: endLightness, alpha: endAlpha),
        alphaCurve: alphaCurve,
        saturationCurve: saturationCurve,
        lightnessCurve: lightnessCurve,
        label: label);
  }

  /// A color defined by interpolation the entire lightness scale.
  factory Color2.fullLightScale(double hue, {double saturation = 1, String? label}) {
    return Color2.shade(
        hue: hue,
        lightestShade: SL(saturation: saturation, lightness: 1),
        darkestShade: SL(saturation: saturation, lightness: 0),
        label: label);
  }

  /// A color defined by interpolation the entire lightness scale.
  factory Color2.fullSaturationScale(double hue, {double lightness = 0.5, String? label}) {
    return Color2.shade(
        hue: hue,
        lightestShade: SL(saturation: 0, lightness: lightness),
        darkestShade: SL(saturation: 1, lightness: lightness),
        label: label);
  }

  factory Color2.material(MaterialColor material, {String? label}) {
    final nine = HSLColor.fromColor(material.shade900);
    return Color2._(
        material.value,
        {
          50: material.shade50,
          100: material.shade100,
          200: material.shade200,
          300: material.shade300,
          400: material.shade400,
          500: material.shade500,
          600: material.shade600,
          700: material.shade700,
          800: material.shade800,
          900: material.shade900,
          950: _interpolate(
                  from: nine,
                  to: HSLColor.fromAHSL(nine.alpha, nine.hue, nine.saturation, 0),
                  tAlpha: 0.25,
                  tHue: 0.25,
                  tSaturation: 0.25,
                  tLightness: 0.25)
              .toColor()
        },
        label: label);
  }

  /// Turns a [Color] into a [Color2]. All shades will be the same color. Prefer [fullLightScale],[shade], or [explicit] if you want the color
  /// to be different shades.
  factory Color2.color(Color color) {
    final material = Color2._(color.value, {
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
      950: color,
    });
    return Color2.material(material);
  }

  /// Convert this color to a [MaterialAccentColor].
  MaterialAccentColor toMaterialAccentColor(
      {int shade100 = 100, int shade200 = 200, int shade400 = 400, int shade700 = 700}) {
    final twoHundred = this[shade200]!;
    final swatch = {
      100: this[shade100]!,
      200: twoHundred,
      400: this[shade400]!,
      700: this[shade700]!
    };

    return MaterialAccentColor(twoHundred.value, swatch);
  }

  const Color2._(super.primary, super.swatch, {this.label});

  @override
  String toString() {
    return label == null ? "Color2" : "Color2(\"$label\")";
  }
}

//************************************************************************//

/// A shade of a color defined by its saturation and lightness (The "SL" in "HSL").
class SL {
  final double saturation;
  final double lightness;
  final double alpha;

  const SL({required this.saturation, required this.lightness, this.alpha = 1});
}

// Dev Note: Taken originally from [HSLColor.lerp]
HSLColor _interpolate(
    {required HSLColor from,
    required HSLColor to,
    required double tAlpha,
    required double tHue,
    required double tSaturation,
    required double tLightness}) {
  if (identical(from, to)) {
    return from;
  }
  return HSLColor.fromAHSL(
    clampDouble(lerpDouble(from.alpha, to.alpha, tAlpha)!, 0.0, 1.0),
    lerpDouble(from.hue, to.hue, tHue)! % 360.0,
    clampDouble(lerpDouble(from.saturation, to.saturation, tSaturation)!, 0.0, 1.0),
    clampDouble(lerpDouble(from.lightness, to.lightness, tLightness)!, 0.0, 1.0),
  );
}

class Colors2 {
  static final Color2 greyNeutral = Color2.implicit(
      shade100: const HSLColor.fromAHSL(1, 0, 0, 0.88),
      shade300: const HSLColor.fromAHSL(1, 0, 0, 0.76),
      shade500: const HSLColor.fromAHSL(1, 0, 0, 0.58),
      shade700: const HSLColor.fromAHSL(1, 0, 0, 0.43),
      shade900: const HSLColor.fromAHSL(1, 0, 0, 0.28));

  static final Color2 greyCool = Color2.implicit(
      shade100: const HSLColor.fromAHSL(1, 208, 0.21, 0.88),
      shade300: const HSLColor.fromAHSL(1, 210, 0.16, 0.76),
      shade500: const HSLColor.fromAHSL(1, 208, 0.12, 0.58),
      shade700: const HSLColor.fromAHSL(1, 207, 0.12, 0.43),
      shade900: const HSLColor.fromAHSL(1, 209, 0.15, 0.28));

  static final Color2 greyWarm = Color2.implicit(
      shade100: const HSLColor.fromAHSL(1, 39, 0.21, 0.88),
      shade300: const HSLColor.fromAHSL(1, 39, 0.16, 0.76),
      shade500: const HSLColor.fromAHSL(1, 39, 0.12, 0.58),
      shade700: const HSLColor.fromAHSL(1, 40, 0.12, 0.43),
      shade900: const HSLColor.fromAHSL(1, 41, 0.15, 0.28));

  /// The dark side of the grey scale
  static final Color2 greyScaleDark = Color2.greyScale(startLightness: 0.5, endLightness: 0);

  /// The light side of the grey scale
  static final Color2 greyScaleLight = Color2.greyScale(startLightness: 1, endLightness: 0.5);

  /// The entire grey scale
  static final Color2 greyScale = Color2.greyScale(startLightness: 1, endLightness: 0);

  // Tailwind colors: https://tailwindcss.com/docs/customizing-colors
  //************************************************************************//

  static final Color2 slate = Color2.explicit(
    shade50: const Color(0xfff8fafc),
    shade100: const Color(0xfff1f5f9),
    shade200: const Color(0xffe2e8f0),
    shade300: const Color(0xffcbd5e1),
    shade400: const Color(0xff94a3b8),
    shade500: const Color(0xff64748b),
    shade600: const Color(0xff475569),
    shade700: const Color(0xff334155),
    shade800: const Color(0xff1e293b),
    shade900: const Color(0xff0f172a),
    shade950: const Color(0xff020617),
  );

  static final Color2 gray = Color2.explicit(
    shade50: const Color(0xfff9fafb),
    shade100: const Color(0xfff3f4f6),
    shade200: const Color(0xffe5e7eb),
    shade300: const Color(0xffd1d5db),
    shade400: const Color(0xff9ca3af),
    shade500: const Color(0xff6b7280),
    shade600: const Color(0xff4b5563),
    shade700: const Color(0xff374151),
    shade800: const Color(0xff1f2937),
    shade900: const Color(0xff111827),
    shade950: const Color(0xff030712),
  );

  static final Color2 zinc = Color2.explicit(
    shade50: const Color(0xfffafafa),
    shade100: const Color(0xfff4f4f5),
    shade200: const Color(0xffe4e4e7),
    shade300: const Color(0xffd4d4d8),
    shade400: const Color(0xffa1a1aa),
    shade500: const Color(0xff71717a),
    shade600: const Color(0xff52525b),
    shade700: const Color(0xff3f3f46),
    shade800: const Color(0xff27272a),
    shade900: const Color(0xff18181b),
    shade950: const Color(0xff09090b),
  );

  static final Color2 neutral = Color2.explicit(
    shade50: const Color(0xfffafafa),
    shade100: const Color(0xfff5f5f5),
    shade200: const Color(0xffe5e5e5),
    shade300: const Color(0xffd4d4d4),
    shade400: const Color(0xffa3a3a3),
    shade500: const Color(0xff737373),
    shade600: const Color(0xff525252),
    shade700: const Color(0xff404040),
    shade800: const Color(0xff262626),
    shade900: const Color(0xff171717),
    shade950: const Color(0xff0a0a0a),
  );

  static final Color2 stone = Color2.explicit(
    shade50: const Color(0xfffafaf9),
    shade100: const Color(0xfff5f5f4),
    shade200: const Color(0xffe7e5e4),
    shade300: const Color(0xffd6d3d1),
    shade400: const Color(0xffa8a29e),
    shade500: const Color(0xff78716c),
    shade600: const Color(0xff57534e),
    shade700: const Color(0xff44403c),
    shade800: const Color(0xff292524),
    shade900: const Color(0xff1c1917),
    shade950: const Color(0xff0c0a09),
  );

  static final Color2 red = Color2.explicit(
    shade50: const Color(0xfffef2f2),
    shade100: const Color(0xfffee2e2),
    shade200: const Color(0xfffecaca),
    shade300: const Color(0xfffca5a5),
    shade400: const Color(0xfff87171),
    shade500: const Color(0xffef4444),
    shade600: const Color(0xffdc2626),
    shade700: const Color(0xffb91c1c),
    shade800: const Color(0xff991b1b),
    shade900: const Color(0xff7f1d1d),
    shade950: const Color(0xff450a0a),
  );

  static final Color2 orange = Color2.explicit(
    shade50: const Color(0xfffff7ed),
    shade100: const Color(0xffffedd5),
    shade200: const Color(0xfffed7aa),
    shade300: const Color(0xfffdba74),
    shade400: const Color(0xfffb923c),
    shade500: const Color(0xfff97316),
    shade600: const Color(0xffea580c),
    shade700: const Color(0xffc2410c),
    shade800: const Color(0xff9a3412),
    shade900: const Color(0xff7c2d12),
    shade950: const Color(0xff431407),
  );

  static final Color2 amber = Color2.explicit(
    shade50: const Color(0xfffffbeb),
    shade100: const Color(0xfffef3c7),
    shade200: const Color(0xfffde68a),
    shade300: const Color(0xfffcd34d),
    shade400: const Color(0xfffbbf24),
    shade500: const Color(0xfff59e0b),
    shade600: const Color(0xffd97706),
    shade700: const Color(0xffb45309),
    shade800: const Color(0xff92400e),
    shade900: const Color(0xff78350f),
    shade950: const Color(0xff451a03),
  );

  static final Color2 yellow = Color2.explicit(
    shade50: const Color(0xfffefce8),
    shade100: const Color(0xfffef9c3),
    shade200: const Color(0xfffef08a),
    shade300: const Color(0xfffde047),
    shade400: const Color(0xfffacc15),
    shade500: const Color(0xffeab308),
    shade600: const Color(0xffca8a04),
    shade700: const Color(0xffa16207),
    shade800: const Color(0xff854d0e),
    shade900: const Color(0xff713f12),
    shade950: const Color(0xff422006),
  );

  static final Color2 lime = Color2.explicit(
    shade50: const Color(0xfff7fee7),
    shade100: const Color(0xffecfccb),
    shade200: const Color(0xffd9f99d),
    shade300: const Color(0xffbef264),
    shade400: const Color(0xffa3e635),
    shade500: const Color(0xff84cc16),
    shade600: const Color(0xff65a30d),
    shade700: const Color(0xff4d7c0f),
    shade800: const Color(0xff3f6212),
    shade900: const Color(0xff365314),
    shade950: const Color(0xff1a2e05),
  );

  static final Color2 green = Color2.explicit(
    shade50: const Color(0xfff0fdf4),
    shade100: const Color(0xffdcfce7),
    shade200: const Color(0xffbbf7d0),
    shade300: const Color(0xff86efac),
    shade400: const Color(0xff4ade80),
    shade500: const Color(0xff22c55e),
    shade600: const Color(0xff16a34a),
    shade700: const Color(0xff15803d),
    shade800: const Color(0xff166534),
    shade900: const Color(0xff14532d),
    shade950: const Color(0xff052e16),
  );

  static final Color2 emerald = Color2.explicit(
    shade50: const Color(0xffecfdf5),
    shade100: const Color(0xffd1fae5),
    shade200: const Color(0xffa7f3d0),
    shade300: const Color(0xff6ee7b7),
    shade400: const Color(0xff34d399),
    shade500: const Color(0xff10b981),
    shade600: const Color(0xff059669),
    shade700: const Color(0xff047857),
    shade800: const Color(0xff065f46),
    shade900: const Color(0xff064e3b),
    shade950: const Color(0xff022c22),
  );

  static final Color2 teal = Color2.explicit(
    shade50: const Color(0xfff0fdfa),
    shade100: const Color(0xffccfbf1),
    shade200: const Color(0xff99f6e4),
    shade300: const Color(0xff5eead4),
    shade400: const Color(0xff2dd4bf),
    shade500: const Color(0xff14b8a6),
    shade600: const Color(0xff0d9488),
    shade700: const Color(0xff0f766e),
    shade800: const Color(0xff115e59),
    shade900: const Color(0xff134e4a),
    shade950: const Color(0xff042f2e),
  );

  static final Color2 cyan = Color2.explicit(
    shade50: const Color(0xffecfeff),
    shade100: const Color(0xffcffafe),
    shade200: const Color(0xffa5f3fc),
    shade300: const Color(0xff67e8f9),
    shade400: const Color(0xff22d3ee),
    shade500: const Color(0xff06b6d4),
    shade600: const Color(0xff0891b2),
    shade700: const Color(0xff0e7490),
    shade800: const Color(0xff155e75),
    shade900: const Color(0xff164e63),
    shade950: const Color(0xff083344),
  );

  static final Color2 sky = Color2.explicit(
    shade50: const Color(0xfff0f9ff),
    shade100: const Color(0xffe0f2fe),
    shade200: const Color(0xffbae6fd),
    shade300: const Color(0xff7dd3fc),
    shade400: const Color(0xff38bdf8),
    shade500: const Color(0xff0ea5e9),
    shade600: const Color(0xff0284c7),
    shade700: const Color(0xff0369a1),
    shade800: const Color(0xff075985),
    shade900: const Color(0xff0c4a6e),
    shade950: const Color(0xff082f49),
  );

  static final Color2 blue = Color2.explicit(
    shade50: const Color(0xffeff6ff),
    shade100: const Color(0xffdbeafe),
    shade200: const Color(0xffbfdbfe),
    shade300: const Color(0xff93c5fd),
    shade400: const Color(0xff60a5fa),
    shade500: const Color(0xff3b82f6),
    shade600: const Color(0xff2563eb),
    shade700: const Color(0xff1d4ed8),
    shade800: const Color(0xff1e40af),
    shade900: const Color(0xff1e3a8a),
    shade950: const Color(0xff172554),
  );

  static final Color2 indigo = Color2.explicit(
    shade50: const Color(0xffeef2ff),
    shade100: const Color(0xffe0e7ff),
    shade200: const Color(0xffc7d2fe),
    shade300: const Color(0xffa5b4fc),
    shade400: const Color(0xff818cf8),
    shade500: const Color(0xff6366f1),
    shade600: const Color(0xff4f46e5),
    shade700: const Color(0xff4338ca),
    shade800: const Color(0xff3730a3),
    shade900: const Color(0xff312e81),
    shade950: const Color(0xff1e1b4b),
  );

  static final Color2 violet = Color2.explicit(
    shade50: const Color(0xfff5f3ff),
    shade100: const Color(0xffede9fe),
    shade200: const Color(0xffddd6fe),
    shade300: const Color(0xffc4b5fd),
    shade400: const Color(0xffa78bfa),
    shade500: const Color(0xff8b5cf6),
    shade600: const Color(0xff7c3aed),
    shade700: const Color(0xff6d28d9),
    shade800: const Color(0xff5b21b6),
    shade900: const Color(0xff4c1d95),
    shade950: const Color(0xff2e1065),
  );

  static final Color2 purple = Color2.explicit(
    shade50: const Color(0xfffaf5ff),
    shade100: const Color(0xfff3e8ff),
    shade200: const Color(0xffe9d5ff),
    shade300: const Color(0xffd8b4fe),
    shade400: const Color(0xffc084fc),
    shade500: const Color(0xffa855f7),
    shade600: const Color(0xff9333ea),
    shade700: const Color(0xff7e22ce),
    shade800: const Color(0xff6b21a8),
    shade900: const Color(0xff581c87),
    shade950: const Color(0xff3b0764),
  );

  static final Color2 fuchsia = Color2.explicit(
    shade50: const Color(0xfffdf4ff),
    shade100: const Color(0xfffae8ff),
    shade200: const Color(0xfff5d0fe),
    shade300: const Color(0xfff0abfc),
    shade400: const Color(0xffe879f9),
    shade500: const Color(0xffd946ef),
    shade600: const Color(0xffc026d3),
    shade700: const Color(0xffa21caf),
    shade800: const Color(0xff86198f),
    shade900: const Color(0xff701a75),
    shade950: const Color(0xff4a044e),
  );

  static final Color2 pink = Color2.explicit(
    shade50: const Color(0xfffdf2f8),
    shade100: const Color(0xfffce7f3),
    shade200: const Color(0xfffbcfe8),
    shade300: const Color(0xfff9a8d4),
    shade400: const Color(0xfff472b6),
    shade500: const Color(0xffec4899),
    shade600: const Color(0xffdb2777),
    shade700: const Color(0xffbe185d),
    shade800: const Color(0xff9d174d),
    shade900: const Color(0xff831843),
    shade950: const Color(0xff500724),
  );

  static final Color2 rose = Color2.explicit(
    shade50: const Color(0xfffff1f2),
    shade100: const Color(0xffffe4e6),
    shade200: const Color(0xfffecdd3),
    shade300: const Color(0xfffda4af),
    shade400: const Color(0xfffb7185),
    shade500: const Color(0xfff43f5e),
    shade600: const Color(0xffe11d48),
    shade700: const Color(0xffbe123c),
    shade800: const Color(0xff9f1239),
    shade900: const Color(0xff881337),
    shade950: const Color(0xff4c0519),
  );
}

class FontSize extends TextStyle {
  @override
  double get fontSize => super.fontSize!;

  const FontSize({required double fontSize, super.height}) : super(fontSize: fontSize);
}

//************************************************************************//

extension Color2OnMaterialColor on MaterialColor {
  Color2 toColor2({String? label}) {
    return Color2.material(this, label: label);
  }
}

extension HSLColorExtension on HSLColor {
  /// Increase the "precieved" brightness (color theory) of the color by rotating the hue towards the closest max brightness hue.
  /// [percent] is a value between 0.0 and 1.0.
  /// Useful for highlight colors. To get a good visual effect you will likely still need to adjust "saturation" and "lightness".
  /// Based on: pg 135 of "refactor ui" by Adam Watham & Steve Schoger
  HSLColor increaseBrightness(double percent) {
    assert(percent >= 0 && percent <= 1);
    double hue = this.hue;
    int closest = _maxsHues.first;
    for (final maxHue in _maxsHues.skip(1)) {
      if ((hue - maxHue).abs() < (hue - closest).abs()) {
        closest = maxHue;
      }
    }
    hue += (closest - hue) * percent;
    return HSLColor.fromAHSL(alpha, hue, saturation, lightness);
  }

  /// Decrease the "precieved" brightness (color theory) of the color by rotating the hue towards the closest min brightness hue.
  /// [percent] is a value between 0.0 and 1.0.
  /// Useful for highlight colors. To get a good visual effect you will likely still need to adjust "saturation" and "lightness".
  /// Based on: pg 135 of "refactor ui" by Adam Watham & Steve Schoger
  HSLColor decreaseBrightness(double percent) {
    assert(percent >= 0 && percent <= 1);
    double hue = this.hue;
    int closest = _minHues.first;
    for (final minHue in _minHues.skip(1)) {
      if ((hue - minHue).abs() < (hue - closest).abs()) {
        closest = minHue;
      }
    }
    hue += (closest - hue) * percent;
    return HSLColor.fromAHSL(alpha, hue, saturation, lightness);
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
