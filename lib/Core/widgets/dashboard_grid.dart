import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/responsive/responsive_extensions.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class ResponsiveDashboardGrid extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveDashboardGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = context.responsive(mobile: 1, tablet: 2, desktop: 4);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: children.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSpacing.cardGap(context),
        mainAxisSpacing: AppSpacing.cardGap(context),
        childAspectRatio: context.isDesktop ? 1.15 : 1.1,
      ),
      itemBuilder: (context, index) => children[index],
    );
  }
}
