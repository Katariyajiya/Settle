import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class C {
  // Primary brand red from Figma
  static const red = Color(0xFFBF3B21);
  static const redDark = Color(0xFF9E2F18);
  static const redLight = Color(0xFFD94F2A);

  // Backgrounds
  static const bg = Color(0xFFF7F4F1);       // warm off-white page bg
  static const surface = Color(0xFFFFFFFF);
  static const surfaceGrey = Color(0xFFF5F5F5);

  // Text
  static const t1 = Color(0xFF1A1A1A);
  static const t2 = Color(0xFF555555);
  static const t3 = Color(0xFF999999);

  // Divider
  static const div = Color(0xFFEAEAEA);

  // Semantic
  static const green = Color(0xFF219653);
  static const greenBg = Color(0xFFE9F7EF);
  static const redNeg = Color(0xFFBF3B21);
  static const teal = Color(0xFF27AE60);
  static const blue = Color(0xFF2F80ED);
  static const purple = Color(0xFF9B51E0);

  // Tags
  static const lunchBg = Color(0xFFFFF3E8);
  static const lunchTxt = Color(0xFFBF6B00);
  static const transportBg = Color(0xFFE8F4FF);
  static const transportTxt = Color(0xFF1565C0);
  static const lodgingBg = Color(0xFFE8F4FF);
  static const lodgingTxt = Color(0xFF1565C0);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: C.red),
        appBarTheme: AppBarTheme(
          backgroundColor: C.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: C.t1,
          ),
          iconTheme: const IconThemeData(color: C.t1, size: 22),
        ),
        textTheme: GoogleFonts.interTextTheme(),
      );
}
