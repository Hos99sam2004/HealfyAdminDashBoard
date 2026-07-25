import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/widgets/dashboard_card.dart';
import 'package:hossam_templete_for_apps/Core/widgets/dashboard_grid.dart';
import 'package:hossam_templete_for_apps/Core/widgets/dashboard_section.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/models/dashboard_model.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DashboardCards extends StatelessWidget {
  final DashboardModel dashboard;
  const DashboardCards({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppSpacing.pagePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xl),
            DashboardSection(
              title: S.of(context).doctorDashboardTitle,
              subtitle: 'Overview of key metrics',
              child: ResponsiveDashboardGrid(
                children: [
                  DashboardCard(
                    title: S.of(context).roleDoctor,
                    value: dashboard.totalDoctors.toString(),
                    icon: Icons.medical_services_outlined,
                    accentColor: AppColors.primary,
                  ),
                  DashboardCard(
                    title: S.of(context).patients,
                    value: dashboard.totalPatients.toString(),
                    icon: Icons.people_outline,
                    accentColor: Colors.orange,
                  ),
                  DashboardCard(
                    title: S.of(context).todayAppointments,
                    value: dashboard.todaysAppointments.toString(),
                    icon: Icons.calendar_today,
                    accentColor: Colors.teal,
                  ),
                  DashboardCard(
                    title: S.of(context).booking_summary,
                    value: dashboard.completedAppointments.toString(),
                    icon: Icons.check_circle_outline,
                    accentColor: AppColors.success,
                  ),
                  DashboardCard(
                    title: S.of(context).payment_summary,
                    value: '\$${dashboard.platformRevenue.toStringAsFixed(2)}',
                    icon: Icons.attach_money,
                    accentColor: Colors.purple,
                  ),
                  DashboardCard(
                    title: S.of(context).statusCancelled,
                    value: dashboard.cancelledAppointments.toString(),
                    icon: Icons.cancel_outlined,
                    accentColor: AppColors.error,
                  ),
                  DashboardCard(
                    title: 'Pending Doctors',
                    value: dashboard.pendingDoctors.toString(),
                    icon: Icons.hourglass_top,
                    accentColor: AppColors.secondary,
                  ),
                  DashboardCard(
                    title: S.of(context).statusCompleted,
                    value: dashboard.verifiedDoctors.toString(),
                    icon: Icons.verified,
                    accentColor: AppColors.success,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            DashboardSection(
              title: S.of(context).popularDoctors,
              subtitle: 'Latest doctors registered',
              child: Column(
                children: dashboard.latestRegisteredDoctors
                    .take(4)
                    .map(
                      (doctor) => _ListItem(
                        title: doctor.name,
                        subtitle: doctor.email ?? doctor.phone ?? '',
                        badge: doctor.profileCompleted ? 'Verified' : 'Pending',
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            DashboardSection(
              title: S.of(context).booking_summary,
              subtitle: 'Recent bookings and status',
              child: Column(
                children: dashboard.latestBookings
                    .take(4)
                    .map(
                      (booking) => _ListItem(
                        title: booking.patientName ?? 'Unknown Patient',
                        subtitle: booking.doctorName ?? 'Unknown Doctor',
                        badge: booking.status,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            DashboardSection(
              title: S.of(context).payment_summary,
              subtitle: 'Recent payments and collections',
              child: Column(
                children: dashboard.latestPayments
                    .take(4)
                    .map(
                      (payment) => _ListItem(
                        title: payment.patientName ?? 'Patient',
                        subtitle:
                            '\$${payment.amount.toStringAsFixed(2)} • ${payment.status}',
                        badge: payment.doctorName ?? 'Doctor',
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;

  const _ListItem({
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
