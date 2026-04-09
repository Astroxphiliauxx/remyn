import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Poppins scale used app-wide. Override color/weight with [TextStyle.copyWith].
abstract final class AppTypography {
  /// Hero / large screen titles (30).
  static TextStyle get display =>
      GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w700);

  /// App bars, page titles (22).
  static TextStyle get title =>
      GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700);

  /// Primary body, buttons, list titles (18).
  static TextStyle get body =>
      GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400);

  /// Captions, secondary lines, chips (14).
  static TextStyle get label =>
      GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400);
}
