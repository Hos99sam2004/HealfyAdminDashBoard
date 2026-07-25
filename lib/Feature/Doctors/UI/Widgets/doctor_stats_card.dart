import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_statistics_model.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorStatsCard extends StatelessWidget {
  final DoctorStatisticsModel statistics;

  const DoctorStatsCard({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding(context),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Wrap(
        spacing: AppSpacing.lg,
        runSpacing: AppSpacing.md,
        children: [
          SizedBox(
            width: 220,
            child: _StatItem(
              label: 'Total Doctors',
              value: statistics.totalDoctors.toString(),
              accentColor: AppColors.primary,
            ),
          ),
          SizedBox(
            width: 220,
            child: _StatItem(
              label: 'Verified Doctors',
              value: statistics.verifiedDoctors.toString(),
              accentColor: AppColors.success,
            ),
          ),
          SizedBox(
            width: 220,
            child: _StatItem(
              label: 'Pending Doctors',
              value: statistics.pendingDoctors.toString(),
              accentColor: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _StatItem({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
