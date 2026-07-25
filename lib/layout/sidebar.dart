// lib/layout/sidebar.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';
import 'package:hossam_templete_for_apps/Core/widgets/logo_widget.dart';

/// Sidebar navigation widget.
/// Width is determined by screen size via [AppSpacing.sidebarWidth].
class Sidebar extends StatelessWidget {
  final bool isCollapsed;
  const Sidebar({Key? key, this.isCollapsed = false}) : super(key: key);

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      route: Routes.dashboard,
    ),
    _NavItem(
      label: 'Doctors',
      icon: Icons.medical_services_outlined,
      route: Routes.doctors,
    ),
    _NavItem(
      label: 'Patients',
      icon: Icons.people_outlined,
      route: Routes.patients,
    ),
    _NavItem(
      label: 'Appointments',
      icon: Icons.calendar_today_outlined,
      route: Routes.appointments,
    ),
    _NavItem(
      label: 'Payments',
      icon: Icons.payment_outlined,
      route: Routes.payments,
    ),
    _NavItem(
      label: 'Reviews',
      icon: Icons.rate_review_outlined,
      route: Routes.reviews,
    ),
    _NavItem(
      label: 'Notifications',
      icon: Icons.notifications_outlined,
      route: Routes.notifications,
    ),
    _NavItem(
      label: 'Reports',
      icon: Icons.bar_chart_outlined,
      route: Routes.reports,
    ),
    _NavItem(
      label: 'Settings',
      icon: Icons.settings_outlined,
      route: Routes.settings,
    ),
    _NavItem(
      label: 'Admins',
      icon: Icons.admin_panel_settings_outlined,
      route: Routes.admins,
    ),
    _NavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      route: Routes.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final sidebarWidth = AppSpacing.sidebarWidth(context);
    final currentRoute = GoRouterState.of(context).uri.toString();

    return SizedBox(
      width: isCollapsed ? null : sidebarWidth,
      child: Drawer(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Container(
          color: AppColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Logo / Brand ────────────────────────────────────────────
              Container(
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Logo(width: 18, height: 18, fit: BoxFit.contain),
                      ),
                    ),
                    if (!isCollapsed) ...[
                      const SizedBox(width: 12),
                      const Text(
                        'Healfy',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // ── Nav Items ───────────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    final isActive = currentRoute.startsWith(item.route);
                    return _SidebarTile(
                      item: item,
                      isActive: isActive,
                      isCollapsed: isCollapsed,
                    );
                  },
                ),
              ),
              // ── Logout ─────────────────────────────────────────────────
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              _SidebarTile(
                item: const _NavItem(
                  label: 'Logout',
                  icon: Icons.logout,
                  route: Routes.logout,
                ),
                isActive: false,
                isCollapsed: isCollapsed,
                isDestructive: true,
              ),
              SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Tile ─────────────────────────────────────────────────────────────────────
class _SidebarTile extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final bool isCollapsed;
  final bool isDestructive;

  const _SidebarTile({
    required this.item,
    required this.isActive,
    required this.isCollapsed,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? AppColors.error
        : isActive
        ? AppColors.primary
        : AppColors.textSecondary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      child: Material(
        color: isActive
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
            context.go(item.route);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 2,
            ),
            child: Row(
              children: [
                Icon(item.icon, color: color, size: 20),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        color: color,
                        fontSize: 14,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Data Model ────────────────────────────────────────────────────────────────
class _NavItem {
  final String label;
  final IconData icon;
  final String route;
  const _NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}
