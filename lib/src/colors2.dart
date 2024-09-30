import 'package:flutter/painting.dart';
import 'package:wind_ui/wind_ui.dart';

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