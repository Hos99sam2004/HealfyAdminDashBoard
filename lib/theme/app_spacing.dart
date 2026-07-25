// lib/theme/app_spacing.dart

import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_extensions.dart';

/// Responsive spacing helpers.
/// All values are derived from the screen width, never fixed pixel values.
class AppSpacing {
  const AppSpacing._();

  // ── Static scale factors (relative to design width 1440) ──────────────────
  static const double _xs = 4;
  static const double _sm = 8;
  static const double _md = 16;
  static const double _lg = 24;
  static const double _xl = 32;
  static const double _xxl = 48;

  // ── Context-aware helpers ─────────────────────────────────────────────────

  /// Horizontal page padding that grows with screen width.
  static double pagePaddingH(BuildContext ctx) =>
      ctx.responsive(mobile: _md, tablet: _lg, desktop: _xl);

  /// Vertical page padding.
  static double pagePaddingV(BuildContext ctx) =>
      ctx.responsive(mobile: _md, tablet: _lg, desktop: _xl);

  static EdgeInsets pagePadding(BuildContext ctx) => EdgeInsets.symmetric(
        horizontal: pagePaddingH(ctx),
        vertical: pagePaddingV(ctx),
      );

  /// Card inner padding.
  static EdgeInsets cardPadding(BuildContext ctx) => EdgeInsets.all(
        ctx.responsive(mobile: _md, tablet: _lg, desktop: _xl),
      );

  /// Gap between cards in a Wrap / Row.
  static double cardGap(BuildContext ctx) =>
      ctx.responsive(mobile: _sm, tablet: _md, desktop: _lg);

  /// Sidebar width (only relevant on desktop/tablet permanent sidebar).
  static double sidebarWidth(BuildContext ctx) =>
      ctx.responsive(mobile: 0, tablet: 220, desktop: 260);

  // ── Plain static values (used where context is unavailable) ───────────────
  static const double xs = _xs;
  static const double sm = _sm;
  static const double md = _md;
  static const double lg = _lg;
  static const double xl = _xl;
  static const double xxl = _xxl;
}
