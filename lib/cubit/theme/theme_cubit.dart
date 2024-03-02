import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/theme/app_theme.dart';

import '../../../theme/theme_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.light);

  getCurrentTheme() async {
    final bool themeIsDark = await ThemePreferences.isDark();
    if (themeIsDark) {
      emit(AppTheme.dark);
    } else {
      emit(AppTheme.light);
    }
  }

  switchTheme() async {
    final isDark = state == AppTheme.dark;

    emit(isDark ? AppTheme.light : AppTheme.dark);
    ThemePreferences.setTheme(isDark);
  }
}
