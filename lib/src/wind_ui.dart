import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:meta/meta.dart';
import 'package:wind_ui/wind_ui.dart';

/// The primary color used in the ui.
mixin Primary {
  /// High-emphasis fills, texts, and icons against surface
  @mustBeOverridden
  Color2 get primary => Colors2.greyNeutral;

  /// Text and icons against primary
  @mustBeOverridden
  Color2 get onPrimary => Colors2.greyNeutral;
}

/// The secondary color used in the ui.
mixin Secondary on Primary {
  /// Less prominent fills, text, and icons against surface
  @mustBeOverridden
  Color2 get secondary => primary;

  /// Text and icons against secondary
  @mustBeOverridden
  Color2 get onSecondary => onPrimary;
}

/// The tertiary color used in the ui.
mixin Tertiary on Secondary {
  /// Complementary fills, text, and icons against surface
  @mustBeOverridden
  Color2 get tertiary => secondary;

  /// Text and icons against Tertiary
  @mustBeOverridden
  Color2 get onTertiary => onSecondary;
}

/// Backgrounds and large, low-emphasis areas of the screen.
mixin Surface {
  /// Backgrounds and large, low-emphasis areas of the screen. Usually [shade100] is somehting akin to white.
  @mustBeOverridden
  Color2 get surface => Colors2.greyNeutral;

  /// Text and icons against surface
  @mustBeOverridden
  Color2 get onSurface => Colors2.greyNeutral;
}

/// The colors used to communicate basic different types of information.
mixin CommunicationAccents {
  /// Attention highlight like "new feature"
  /// The color used for primary actions that do not have a neutral connotation
  /// e.g. "go to page" is not positive or negative. This can be the primary or secondary color,
  /// but different shades will likely be used than the usual uses of primary or secondary.
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
mixin NeutralAccent {
  /// Neutral accent color used for low-emphasis areas of the screen. Often shades of grey
  Color2 get neutral => Colors2.greyNeutral;
}

mixin WhiteAndBlack {
  Color2 get white => Colors2.white;

  Color2 get black => Colors2.black;
}

mixin TextSelectionAccent {
  @mustBeOverridden
  Color2 get textSelection => Colors2.greyCool;
  @mustBeOverridden
  Color2 get textSelectionCursor => Colors2.greyCool;
}

/// The default container decorations. Any variations from the default should probably be made relative to
/// the default e.g.
/// ```dart
///  final differentShadow = shadow + x;
/// ```
// Dev Note: Things like "border color" are not included since they are usually dependent Jon the colors
// currently being worked with, while something like "shadow color" is usually consistent.
mixin ContainerStyle {
  /// The radius on the corners of objects, aka border radius.
  ///
  /// A small border radius is pretty neutral, and doesn’t really communicate
  /// much of a personality on its own, while a large border radius starts to feel more playful,
  /// and no border radius at all feels a lot more serious or formal.
  double get cornerRadius => 0;

  /// The shadow color.
  Color2 get shadow => Colors2.greyScaleDark;

  /// The radius of the shadow. aka elevation
  double get shadowRadius => 3;
}

mixin FontStyle {
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
}

abstract class FullTheme extends FullMaterialTheme
    with
        Primary,
        Secondary,
        Tertiary,
        Surface,
        CommunicationAccents,
        NeutralAccent,
        TextSelectionAccent,
        ContainerStyle,
        FontStyle,
        WhiteAndBlack {}

abstract class FullMaterialTheme extends BasicMaterialTheme
    with Tertiary, ContainerStyle, TextSelectionAccent, ContainerStyle {
  @override
  ThemeData createMaterialThemeData() {
    final brightness = ThemeData.estimateBrightnessForColor(primary);

    final colorScheme = ColorScheme(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: surface,
      error: destructive,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onTertiary: onTertiary,
      onSurface: onSurface,
      onError: Colors.white,
      shadow: shadow,
      brightness: brightness,
    );
    final bool isDark = colorScheme.brightness == Brightness.dark;

    // For surfaces that use primary color in light themes and surface color in dark
    final Color primarySurfaceColor = isDark ? colorScheme.surface : colorScheme.primary;
    final Color onPrimarySurfaceColor = isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    return ThemeData(
        colorScheme: colorScheme,
        brightness: colorScheme.brightness,
        primaryColor: primarySurfaceColor,
        canvasColor: colorScheme.surface,
        scaffoldBackgroundColor: colorScheme.surface,
        cardColor: colorScheme.surface,
        dividerColor: colorScheme.onSurface.withOpacity(0.12),
        dialogBackgroundColor: colorScheme.surface,
        indicatorColor: onPrimarySurfaceColor,
        textTheme: fontFamily,
        applyElevationOverlayColor: isDark,
        useMaterial3: true,
        //
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: textSelection,
            selectionHandleColor: textSelectionCursor,
            cursorColor: textSelectionCursor),
        primaryTextTheme: fontFamily);
  }
}

/// Minimum specification needed to create a material theme
abstract class BasicMaterialTheme
    with Primary, Secondary, Surface, CommunicationAccents, FontStyle {
  ThemeData createMaterialThemeData() {
    final colorScheme = ColorScheme(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: destructive,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
      onSurface: onSurface,
      onError: Colors.white,
      brightness: ThemeData.estimateBrightnessForColor(primary),
    );

    return ThemeData.from(colorScheme: colorScheme, textTheme: fontFamily, useMaterial3: true);
  }
}

class FontSize extends TextStyle {
  @override
  double get fontSize => super.fontSize!;

  const FontSize({required double fontSize, super.height}) : super(fontSize: fontSize);
}
