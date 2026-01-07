import 'package:blog_app/core/theme/appcolors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static  _border([Color color = AppColors.borderColor]) => OutlineInputBorder(
      borderSide:  BorderSide(color: color,
          width: 3),
    borderRadius: BorderRadius.circular(10)
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme:  const AppBarTheme(
      backgroundColor:  AppColors.backgroundColor,
    ),
    chipTheme: ChipThemeData(
      side: BorderSide.none,
      color:  MaterialStatePropertyAll(AppColors.backgroundColor,),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      border: OutlineInputBorder(
        borderSide: BorderSide(color:  AppColors.borderColor,
            width: 3)
      ),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor),
    )
  );
}