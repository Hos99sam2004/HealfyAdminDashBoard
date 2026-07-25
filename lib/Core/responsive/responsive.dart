// lib/Core/responsive/responsive.dart

import 'package:flutter/material.dart';
import 'responsive_extensions.dart';

/// A widget that renders [desktop], [tablet], or [mobile] based on screen width.
///
/// Usage:
/// ```dart
/// ResponsiveLayout(
///   desktop: DesktopView(),
///   tablet:  TabletView(),
///   mobile:  MobileView(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  const ResponsiveLayout({
    Key? key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) return desktop;
    if (context.isTablet) return tablet;
    return mobile;
  }
}

/// Convenience builder variant with a [LayoutBuilder] callback.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints) builder;

  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: builder);
  }
}
