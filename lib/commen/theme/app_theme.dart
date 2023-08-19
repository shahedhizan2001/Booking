import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'light_color_schema.dart';

const defaultAppTheme = ThemeMode.system;
var sysBrightness = SchedulerBinding.instance.window.platformBrightness;

ThemeData getAppTheme(ThemeMode mode, BuildContext context) {
  final mapAppTheme = <ThemeMode, ThemeData>{
    ThemeMode.light: AppTheme.light(context),
  };

  return mapAppTheme[mode]!;
}

class AppTheme {
  static ThemeData get _builtInLightTheme => ThemeData.light();

  static ThemeData light(BuildContext context) {
    return _builtInLightTheme.copyWith(
      //colorScheme: lightColorScheme,
      // useMaterial3: true,
      scaffoldBackgroundColor: lightColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.onPrimary,
        elevation: 0,
        toolbarHeight: 50.h,
      ),

      iconTheme: IconThemeData(
        color: lightColorScheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: lightColorScheme.surfaceTint,
          onPrimary: lightColorScheme.onPrimary,
          onSurface: lightColorScheme.onSurface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        ),
      ),
      cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(15.r)),
          color: lightColorScheme.background),
    );
  }
}
