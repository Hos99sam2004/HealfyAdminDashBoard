// lib/Core/responsive/responsive_extensions.dart

import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Extension on [BuildContext] for convenient responsive helpers.
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  DeviceScreenType get deviceType {
    final w = screenWidth;
    if (Breakpoints.isDesktop(w)) return DeviceScreenType.desktop;
    if (Breakpoints.isTablet(w)) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }

  bool get isDesktop => deviceType == DeviceScreenType.desktop;
  bool get isTablet => deviceType == DeviceScreenType.tablet;
  bool get isMobile => deviceType == DeviceScreenType.mobile;

  /// Returns a value based on the current device type.
  T responsive<T>({required T mobile, required T tablet, required T desktop}) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    return mobile;
  }

  /// Responsive horizontal padding (5% on mobile, 4% on tablet, 3% on desktop).
  double get horizontalPadding =>
      responsive(mobile: screenWidth * 0.05, tablet: screenWidth * 0.04, desktop: screenWidth * 0.03);

  /// Responsive font scale factor.
  double get fontScale =>
      responsive(mobile: 0.85, tablet: 0.92, desktop: 1.0);
}
