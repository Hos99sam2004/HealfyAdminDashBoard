// lib/Core/responsive/breakpoints.dart

/// Breakpoint constants matching the project's design spec.
/// Mobile  : width < 768
/// Tablet  : 768 <= width < 1200
/// Desktop : width >= 1200
class Breakpoints {
  const Breakpoints._();

  static const double mobile = 768;
  static const double tablet = 1200;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}

/// Enum representing the three supported device types.
enum DeviceScreenType { mobile, tablet, desktop }
