// lib/layout/responsive_scaffold.dart

import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_layout.dart';
import 'package:hossam_templete_for_apps/layout/custom_sidebar.dart';
import 'package:hossam_templete_for_apps/layout/custom_top_bar.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';

/// The main shell of the admin dashboard.
///
/// - Desktop  (>= 1200): Permanent sidebar on the left, content fills remaining space.
/// - Tablet   (768-1199): Drawer-based sidebar, TopBar with hamburger icon.
/// - Mobile   (< 768)  : Drawer-based sidebar, TopBar with hamburger icon.
class ResponsiveScaffold extends StatefulWidget {
  final Widget child;
  const ResponsiveScaffold({Key? key, required this.child}) : super(key: key);

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktop: _DesktopShell(child: widget.child),
      tablet: _DrawerShell(child: widget.child),
      mobile: _DrawerShell(child: widget.child),
    );
  }
}

// ── Desktop: permanent sidebar ────────────────────────────────────────────
class _DesktopShell extends StatefulWidget {
  final Widget child;
  const _DesktopShell({required this.child});

  @override
  State<_DesktopShell> createState() => _DesktopShellState();
}

class _DesktopShellState extends State<_DesktopShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          const CustomSidebar(),
          Expanded(
            child: Column(
              children: [
                CustomTopBar(showDrawerButton: false),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tablet / Mobile: drawer ───────────────────────────────────────────────
class _DrawerShell extends StatelessWidget {
  final Widget child;
  const _DrawerShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomTopBar(
        showDrawerButton: true,
        onMenuPressed: () => Scaffold.of(context).openDrawer(),
      ),
      drawer: const CustomSidebar(),
      body: child,
    );
  }
}
