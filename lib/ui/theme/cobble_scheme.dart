import 'package:flutter/material.dart';

class CobbleScheme extends InheritedWidget {
  final CobbleSchemeData schemeData;

  const CobbleScheme({
    Key? key,
    required this.schemeData,
    required Widget child,
  })  : assert(schemeData != null),
        assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant CobbleScheme oldWidget) =>
      oldWidget.schemeData != schemeData;

  static CobbleSchemeData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CobbleScheme>()
        ?.schemeData;
  }
}

class CobbleSchemeData {
  final Brightness brightness;

  /// Used for controls such as switches, buttons, and as a selection indicator.
  final Color primary;

  /// Used for secondary controls.
  final Color secondary;

  /// Used for tertiary controls.
  final Color tertiary;

  /// Background color for dialogs about dangerous actions.
  final Color danger;

  /// Used for destructive actions, such as deleting a database or factory resetting a watch.
  final Color destructive;

  /// Used for successful actions like connected watch.
  final Color success;

  /// Page background.
  final Color background;

  /// Used for elevated components such as cards.
  final Color surface;

  /// Used for highest-elevation components like toolbars and dialog backgrounds.
  final Color elevated;

  /// Primary text color.
  final Color text;

  /// Secondary or disabled text.
  final Color muted;

  /// Divider lines and highlighting icons/illustrations.
  final Color divider;

  CobbleSchemeData({
    required this.brightness,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.danger,
    required this.destructive,
    required this.success,
    required this.background,
    required this.surface,
    required this.elevated,
    required this.text,
    required this.muted,
    required this.divider,
  });

  static final _darkScheme = CobbleSchemeData(
    brightness: Brightness.dark,
    primary: Color(0xFFF9A285),
    secondary: Color(0xFFF9A285),
    tertiary: Color(0xFFF9A285),
    danger: Color(0xFFAF0000),
    destructive: Color(0xFFFF7575),
    success: Color(0xFF78F9CD),
    background: Color(0xFF333333),
    surface: Color(0xFF414141),
    elevated: Color(0xFF484848),
    text: Color(0xFFFFFFFF),
    muted: Color(0xFFFFFFFF).withOpacity(0.6),
    divider: Color(0xFFFFFFFF).withOpacity(0.35),
  );

  static final _lightScheme = CobbleSchemeData(
    brightness: Brightness.light,
    primary: Color(0xFFB12C00),
    secondary: Color(0xFF77574E),
    tertiary: Color(0xFFF5E1A6),
    danger: Color(0xFFFFDAD4),
    destructive: Color(0xFFBA1B1B),
    success: Color(0xFF78F9CD),
    background: Color(0xFFFCFCFC),
    surface: Color(0xFFF6EBE8),
    elevated: Color(0xFFF8F2EF),
    text: Color(0xFF201A18),
    muted: Color(0xFF86736E),
    divider: Color(0xFF86736E),
  );

  factory CobbleSchemeData.fromBrightness(Brightness? brightness) =>
      brightness == Brightness.light ? _lightScheme : _darkScheme;

  CobbleSchemeData invert() => this.brightness == Brightness.dark
      ? CobbleSchemeData.fromBrightness(Brightness.light)
      : CobbleSchemeData.fromBrightness(Brightness.dark);
}
