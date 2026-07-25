import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/widgets/custom_search_bar.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_extensions.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawerButton;
  final VoidCallback? onMenuPressed;

  const CustomTopBar({
    Key? key,
    this.showDrawerButton = false,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.pagePaddingH(context),
        vertical: AppSpacing.sm,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (showDrawerButton) ...[
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                onPressed: onMenuPressed,
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: context.responsive(
                        mobile: 20,
                        tablet: 24,
                        desktop: 30,
                      ),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Welcome back, here is your admin overview.',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            if (!isDesktop) Expanded(child: CustomSearchBar()),
            if (isDesktop) ...[
              Expanded(child: CustomSearchBar()),
              const SizedBox(width: AppSpacing.lg),
              const _ActionsRow(),
            ],
            if (!isDesktop) const _ActionsRow(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BadgeIcon(icon: Icons.search, label: 'Search'),
        const SizedBox(width: AppSpacing.md),
        _BadgeIcon(icon: Icons.notifications_none, label: 'Notifications'),
        const SizedBox(width: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: const [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(width: AppSpacing.xs),
              Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BadgeIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.textSecondary.withOpacity(0.16)),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 22),
      ),
    );
  }
}
