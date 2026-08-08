import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Screens/DoctorDetailsScreen.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorListCard extends StatelessWidget {
  final List<DoctorModel> doctors;
  final String? selectedDoctorId;
  final ValueChanged<String> onDoctorSelected;

  const DoctorListCard({
    super.key,
    required this.doctors,
    required this.selectedDoctorId,
    required this.onDoctorSelected,
  });

  bool _isActionLoading(DoctorsState state) =>
      state is BulkApprovedLoading || state is BulkRejectedLoading;

  Future<void> _showRejectDialog(BuildContext context, String doctorId) async {
    final controller = TextEditingController();

    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject doctor'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Rejection reason',
            hintText: 'Enter the reason for rejection',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              final value = controller.text.trim();
              if (value.isEmpty) return;
              Navigator.pop(dialogContext, value);
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    controller.dispose();
    if (reason == null || !context.mounted) return;

    await context.read<DoctorsCubit>().rejectDoctor(
      reason,
      doctorId: doctorId,
    );
  }

  Future<void> _openDetails(BuildContext context, DoctorModel doctor) async {
    final cubit = context.read<DoctorsCubit>();
    await cubit.loadDoctorDetails(doctor.id);
    if (!context.mounted) return;

    final state = cubit.state;
    if (state is DoctorsLoaded && state.selectedDoctor != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Doctordetailsscreen(doctor: state.selectedDoctor!),
        ),
      );
    }
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doctors List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Select a doctor to view full details.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (doctors.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text(
                  'No doctors found.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: doctors.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                final isSelected = doctor.id == selectedDoctorId;
                final status = doctor.status?.toLowerCase();
                final isLoading = _isActionLoading(context.read<DoctorsCubit>().state);

                return Material(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.08)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: isLoading ? null : () => onDoctorSelected(doctor.id),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.sm,
                        children: [
                          SizedBox(
                            width: 280,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: AppColors.primary.withOpacity(0.12),
                                  backgroundImage: doctor.avatarUrl != null
                                      ? NetworkImage(doctor.avatarUrl!)
                                      : null,
                                  child: doctor.avatarUrl == null
                                      ? const Icon(
                                          Icons.person_outline,
                                          color: AppColors.primary,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor.fullName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        doctor.specialty ?? doctor.email ?? 'Not available',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _StatusChip(status: status),
                          if (status == 'pending')
                            Wrap(
                              spacing: AppSpacing.xs,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: isLoading
                                      ? null
                                      : () => context.read<DoctorsCubit>().approveDoctor(
                                            doctorId: doctor.id,
                                          ),
                                  icon: const Icon(Icons.check, size: 18),
                                  label: const Text('Approve'),
                                ),
                                OutlinedButton.icon(
                                  onPressed: isLoading
                                      ? null
                                      : () => _showRejectDialog(context, doctor.id),
                                  icon: const Icon(Icons.close, size: 18),
                                  label: const Text('Reject'),
                                ),
                              ],
                            ),
                          IconButton(
                            tooltip: 'View details',
                            onPressed: isLoading ? null : () => _openDetails(context, doctor),
                            icon: const Icon(Icons.visibility_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String? status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final normalized = status ?? 'pending';
    final color = switch (normalized) {
      'approved' => AppColors.success,
      'rejected' => AppColors.error,
      _ => AppColors.secondary,
    };
    final label = switch (normalized) {
      'approved' => 'Approved',
      'rejected' => 'Rejected',
      _ => 'Pending',
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
