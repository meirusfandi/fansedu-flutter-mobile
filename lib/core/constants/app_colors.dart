import 'package:flutter/material.dart';

/// Warna utama brand Fansedu (dari logo: biru–teal obor & buku).
class AppColors {
  AppColors._();

  /// Primary: biru teal dari ikon logo (obor/buku).
  static const Color primary = Color(0xFF00AACC);

  /// Primary terang untuk aksen (ujung obor).
  static const Color primaryLight = Color(0xFF00CFFF);

  /// Primary gelap untuk contrast.
  static const Color primaryDark = Color(0xFF0099CC);

  /// Secondary: biru desaturasi (teks "OLYMPIAD ACADEMY").
  static const Color secondary = Color(0xFFA3D4E7);

  /// Background dark theme (navy dari logo).
  static const Color darkBackground = Color(0xFF0E1624);

  /// Surface dark theme (sedikit lebih terang dari background).
  static const Color darkSurface = Color(0xFF162536);
}
