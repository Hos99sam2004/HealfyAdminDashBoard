// lib/layout/top_bar.dart

import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_extensions.dart';
import 'package:hossam_templete_for_apps/Feature/Search/UI/Screens/PatientSearchScreen.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

/// Top application bar.
/// On tablet/mobile the [showDrawerButton] hamburger icon opens the drawer.
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showDrawerButton;
  const TopBar({Key? key, this.showDrawerButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: const Color(0xFFE2E8F0),
      titleSpacing: AppSpacing.pagePaddingH(context),
      leadingWidth: showDrawerButton ? 56 : 0,
      leading: showDrawerButton
          ? IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )
          : null,
      title: Text(
        'Healfy Admin',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: context.responsive(
            mobile: 16.0,
            tablet: 17.0,
            desktop: 18.0,
          ),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        // Search
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textSecondary),
          onPressed: () {},
        ),
        // Notifications
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textSecondary,
          ),
          onPressed: () {},
        ),
        // Avatar
        Padding(
          padding: EdgeInsets.only(right: AppSpacing.md),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: const Icon(Icons.person, color: AppColors.primary, size: 18),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
