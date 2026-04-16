import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primary Brand ─────────────────────────────────────────────────────────
  /// Yukem Blue – hsl(213, 94%, 48%)  →  #0969E9
  static const Color primary      = Color(0xFF0969E9);
  /// Yukem Blue Light (dark mode) – hsl(213, 94%, 52%)
  static const Color primaryLight = Color(0xFF1A78F5);
  /// Yukem Purple accent – hsl(262, 83%, 58%)
  static const Color purple       = Color(0xFF7C3AED);
  /// Yukem Cyan – hsl(199, 89%, 48%)
  static const Color cyan         = Color(0xFF0AB5E6);

  // ── Gradient pairs ────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0969E9), Color(0xFF1A78F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF0A1628), Color(0xFF0D2D6B), Color(0xFF0969E9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Backgrounds & Surfaces ────────────────────────────────────────────────
  /// Light mode – hsl(210, 5%, 98%)
  static const Color background     = Color(0xFFF7F9FB);
  static const Color surface        = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  /// Dark mode – hsl(210, 6%, 8%)
  static const Color backgroundDark = Color(0xFF111518);
  /// Dark cards – hsl(210, 6%, 10%)
  static const Color surfaceDark    = Color(0xFF161B22);
  /// Dark elevated – hsl(210, 6%, 12%)
  static const Color elevatedDark   = Color(0xFF1C2330);

  // ── Borders ───────────────────────────────────────────────────────────────
  static const Color border     = Color(0xFFE2E8F0);  // light
  static const Color borderDark = Color(0xFF222D3D);  // dark

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary        = Color(0xFF0F172A);
  static const Color textSecondary      = Color(0xFF64748B);
  static const Color textMuted          = Color(0xFF94A3B8);
  static const Color textPrimaryDark    = Color(0xFFEFF2F7);
  static const Color textSecondaryDark  = Color(0xFF94A3B8);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color error   = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info    = Color(0xFF3B82F6);

  // ── Chart colors (follows ERP) ────────────────────────────────────────────
  static const Color chart1 = Color(0xFF0969E9); // Blue
  static const Color chart2 = Color(0xFF10B981); // Green
  static const Color chart3 = Color(0xFF7C3AED); // Purple
  static const Color chart4 = Color(0xFFF59E0B); // Amber
  static const Color chart5 = Color(0xFFEF4444); // Red

  // ── Glass ─────────────────────────────────────────────────────────────────
  static const Color glassBg     = Color(0x66FFFFFF); // 40% white
  static const Color glassBgDark = Color(0x991C2330); // 60% dark card
}
