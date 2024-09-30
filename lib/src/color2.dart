import 'dart:ui';

import 'package:flutter/material.dart';

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

  /// A step beyond the usual lightest shade.
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

  /// A step beyond the usual darkest shade.
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
    String? label,
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
    return Color2._(shade500.value, swatch, label: label);
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

    final shade100C = shade100.toColor();
    final shade200C = colorsC[1].toColor();
    final shade300C = colorsC[2].toColor();
    final shade400C = colorsC[3].toColor();
    final shade500C = colorsC[4].toColor();
    final shade600C = colorsC[5].toColor();
    final shade700C = colorsC[6].toColor();
    final shade800C = colorsC[7].toColor();
    final shade900C = shade900.toColor();

    final Map<int, Color> swatch = {
      50: shade50?.toColor() ??
          _relativeInterpolate(
            from: HSLColor.fromColor(shade200C),
            to: HSLColor.fromColor(shade100C),
            percent: 0.5,
          ).toColor(),
      100: shade100C,
      200: shade200C,
      300: shade300C,
      400: shade400C,
      500: shade500C,
      600: shade600C,
      700: shade700C,
      800: shade800C,
      900: shade900C,
      950: shade950?.toColor() ??
          _relativeInterpolate(
            from: HSLColor.fromColor(shade800C),
            to: HSLColor.fromColor(shade900C),
            percent: 0.5,
          ).toColor()
    };
    return Color2._(shade500C.value, swatch, label: label);
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

    final shade100 = shade100Hsl.toColor();
    final shade200 = shade200Hsl.toColor();
    final shade300 = shade300Hsl.toColor();
    final shade400 = shade400Hsl.toColor();
    final shade500 = shade500Hsl.toColor();
    final shade600 = shade600Hsl.toColor();
    final shade700 = shade700Hsl.toColor();
    final shade800 = shade800Hsl.toColor();
    final shade900 = shade900Hsl.toColor();

    final swatch = {
      50: _relativeInterpolate(
        from: HSLColor.fromColor(shade200),
        to: HSLColor.fromColor(shade100),
        percent: 0.5,
      ).toColor(),
      100: shade100,
      200: shade200,
      300: shade300,
      400: shade400,
      500: shade500,
      600: shade600,
      700: shade700,
      800: shade800,
      900: shade900,
      950: _relativeInterpolate(
        from: HSLColor.fromColor(shade800),
        to: HSLColor.fromColor(shade900),
        percent: 0.5,
      ).toColor()
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
          950: _relativeInterpolate(
            from: HSLColor.fromColor(material.shade800),
            to: HSLColor.fromColor(material.shade900),
            percent: 0.5,
          ).toColor()
        },
        label: label);
  }

  /// Turns a [Color] into a [Color2]. All shades will be the same color. Prefer [fullLightScale],[shade], or [explicit] if you want the color
  /// to be different shades.
  factory Color2.color(Color color, {String? label}) {
    final material = Color2._(
        color.value,
        {
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
        },
        label: label);
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

/// Interpolates relative to the last step size. [percent] of 1 meaning take the same step size, -1 take the same step
/// size in the opposite direction. [to] will always be the reference, so if you want the opposite direction, switch
/// the inputs.
HSLColor _relativeInterpolate(
    {required HSLColor from, required HSLColor to, required double percent}) {
  final alphaStep = to.alpha - from.alpha;
  final hueStep = to.hue - from.hue;
  final saturationStep = to.saturation - from.saturation;
  final lightnessStep = to.lightness - from.lightness;
  final ref = to;
  return HSLColor.fromAHSL(
    clampDouble(ref.alpha + (alphaStep * percent), 0.0, 1.0),
    (ref.hue + (hueStep * percent)) % 360.0,
    clampDouble(ref.saturation + (saturationStep * percent), 0.0, 1.0),
    clampDouble(ref.lightness + (lightnessStep * percent), 0.0, 1.0),
  );
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
