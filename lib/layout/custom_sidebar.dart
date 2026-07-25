import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/widgets/logo_widget.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_extensions.dart';

class CustomSidebar extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback? onClose;

  const CustomSidebar({Key? key, this.isCollapsed = false, this.onClose})
    : super(key: key);

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final width = isDesktop ? 280.0 : 260.0;
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Container(
      width: widget.isCollapsed ? 80 : width,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Logo(width: 26, height: 26, fit: BoxFit.contain),
                  ),
                ),
                if (!widget.isCollapsed) ...[
                  const SizedBox(width: AppSpacing.md),
                  const Expanded(
                    child: Text(
                      'Healfy Admin',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              children: _navItems.map((item) {
                final active = currentRoute.startsWith(item.route);
                return _SidebarItem(
                  item: item,
                  isCollapsed: widget.isCollapsed,
                  isActive: active,
                  onTap: () {
                    context.go(item.route);
                    widget.onClose?.call();
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _SidebarItem(
            item: const _SidebarNavItem(
              label: 'Logout',
              icon: Icons.logout_outlined,
              route: Routes.logout,
            ),
            isCollapsed: widget.isCollapsed,
            isActive: false,
            isDestructive: true,
            onTap: () {
              context.go(Routes.logout);
              widget.onClose?.call();
            },
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final _SidebarNavItem item;
  final bool isCollapsed;
  final bool isActive;
  final bool isDestructive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.item,
    required this.isCollapsed,
    required this.isActive,
    required this.onTap,
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      child: Material(
        color: isActive
            ? AppColors.primary.withOpacity(0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Icon(item.icon, size: 22, color: color),
                if (!isCollapsed) ...[
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: color,
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

class _SidebarNavItem {
  final String label;
  final IconData icon;
  final String route;

  const _SidebarNavItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}

const List<_SidebarNavItem> _navItems = [
  _SidebarNavItem(
    label: 'Dashboard',
    icon: Icons.dashboard_outlined,
    route: Routes.dashboard,
  ),
  _SidebarNavItem(
    label: 'Doctors',
    icon: Icons.medical_services_outlined,
    route: Routes.doctors,
  ),
  _SidebarNavItem(
    label: 'Patients',
    icon: Icons.people_outlined,
    route: Routes.patients,
  ),
  _SidebarNavItem(
    label: 'Appointments',
    icon: Icons.calendar_today_outlined,
    route: Routes.appointments,
  ),
  _SidebarNavItem(
    label: 'Payments',
    icon: Icons.payment_outlined,
    route: Routes.payments,
  ),
  _SidebarNavItem(
    label: 'Reviews',
    icon: Icons.rate_review_outlined,
    route: Routes.reviews,
  ),
  _SidebarNavItem(
    label: 'Notifications',
    icon: Icons.notifications_outlined,
    route: Routes.notifications,
  ),
  _SidebarNavItem(
    label: 'Reports',
    icon: Icons.bar_chart_outlined,
    route: Routes.reports,
  ),
  _SidebarNavItem(
    label: 'Settings',
    icon: Icons.settings_outlined,
    route: Routes.settings,
  ),
  _SidebarNavItem(
    label: 'Admins',
    icon: Icons.admin_panel_settings_outlined,
    route: Routes.admins,
  ),
  _SidebarNavItem(
    label: 'Profile',
    icon: Icons.person_outline,
    route: Routes.profile,
  ),
];
