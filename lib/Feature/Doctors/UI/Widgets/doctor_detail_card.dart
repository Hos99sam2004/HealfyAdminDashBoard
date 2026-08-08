import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_documents_section.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorDetailCard extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const DoctorDetailCard({super.key, required this.doctor});

  String _statusLabel(String? value) {
    switch (value?.toLowerCase()) {
      case 'approved':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  Color _statusColor(String? value) {
    switch (value?.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.secondary;
    }
  }

  String _rating() {
    if (doctor.rating == null) return 'Not available';
    return '${doctor.rating!.toStringAsFixed(1)}/5';
  }

  String _reviews() {
    if (doctor.totalReviews == null) return 'No reviews';
    return doctor.totalReviews.toString();
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(doctor.status);

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: AppColors.primary.withOpacity(0.12),
                backgroundImage: doctor.avatarUrl != null
                    ? NetworkImage(doctor.avatarUrl!)
                    : null,
                child: doctor.avatarUrl == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 32,
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
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      doctor.specialty ?? 'Doctor',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _Pill(label: _statusLabel(doctor.status)),
                        _Pill(label: '${_rating()} Rating'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _StatusChip(
                label: _statusLabel(doctor.status),
                color: statusColor,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _AdminStatusActions(doctor: doctor),
          const SizedBox(height: AppSpacing.lg),
          _ResponsiveDetailWrap(
            children: [
              _DetailTile(label: 'Email', value: doctor.email ?? 'Not available'),
              _DetailTile(label: 'Phone', value: doctor.phone ?? 'Not available'),
              _DetailTile(label: 'Clinic', value: doctor.clinicName ?? 'Not available'),
              _DetailTile(label: 'City', value: doctor.city ?? 'Not available'),
              _DetailTile(label: 'Address', value: doctor.address ?? 'Not available'),
              _DetailTile(label: 'License', value: doctor.licenseNumber ?? 'Not available'),
              _DetailTile(
                label: 'Experience',
                value: doctor.yearsExperience == null
                    ? 'Not available'
                    : '${doctor.yearsExperience} years',
              ),
              _DetailTile(
                label: 'Consultation Price',
                value: doctor.consultationPrice == null
                    ? 'Not available'
                    : doctor.consultationPrice!.toStringAsFixed(0),
              ),
              _DetailTile(
                label: 'Joined',
                value: doctor.joinedAt == null
                    ? 'Not available'
                    : _formatDate(doctor.joinedAt!),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'Professional Information'),
          const SizedBox(height: AppSpacing.sm),
          _ResponsiveDetailWrap(
            children: [
              _DetailTile(label: 'Specialty', value: doctor.specialty ?? 'Not available'),
              _DetailTile(label: 'Verification', value: _statusLabel(doctor.status)),
              _DetailTile(label: 'Rating', value: _rating()),
              _DetailTile(label: 'Reviews', value: _reviews()),
              _DetailTile(
                label: 'Profile',
                value: doctor.profileCompleted ? 'Complete' : 'Incomplete',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'About'),
          const SizedBox(height: AppSpacing.sm),
          Text(
            doctor.bio?.trim().isNotEmpty == true
                ? doctor.bio!
                : 'No biography available.',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const _SectionHeader(title: 'Working Days'),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: doctor.workingDays.isEmpty
                ? [
                    const Text(
                      'No schedule data available.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ]
                : doctor.workingDays.map((day) => _Pill(label: day)).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          DoctorDocumentsSection(documents: doctor.documents),
          if (doctor.status?.toLowerCase() == 'rejected' &&
              doctor.verificationReason?.trim().isNotEmpty == true) ...[
            const SizedBox(height: AppSpacing.lg),
            const _SectionHeader(title: 'Rejection Reason'),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.error.withOpacity(0.12)),
              ),
              child: Text(
                doctor.verificationReason!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AdminStatusActions extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const _AdminStatusActions({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state is DoctorStatusChangeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is DoctorStatusChangeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Doctor status updated successfully.')),
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final loading = state is DoctorStatusChangeLoading;

        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            OutlinedButton.icon(
              onPressed: loading
                  ? null
                  : () => _showChangeStatusDialog(context),
              icon: loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.swap_horiz),
              label: const Text('Change Status'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showChangeStatusDialog(BuildContext context) async {
    final cubit = context.read<DoctorsCubit>();
    var selectedStatus = doctor.status?.toLowerCase() ?? 'pending';
    final reasonController = TextEditingController(
      text: doctor.status?.toLowerCase() == 'rejected'
          ? doctor.verificationReason ?? ''
          : '',
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final isRejected = selectedStatus == 'rejected';

            return AlertDialog(
              title: const Text('Change Doctor Status'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select the new status for this doctor.'),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(value: 'pending', child: Text('Pending')),
                        DropdownMenuItem(value: 'approved', child: Text('Approved')),
                        DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedStatus = value);
                        }
                      },
                    ),
                    if (isRejected) ...[
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: reasonController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Rejection Reason',
                          hintText: 'Enter the reason for rejection',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (isRejected && reasonController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rejection reason is required.'),
                        ),
                      );
                      return;
                    }

                    Navigator.of(dialogContext).pop();
                    cubit.changeDoctorStatus(
                      doctorId: doctor.id,
                      status: selectedStatus,
                      reason: isRejected ? reasonController.text.trim() : null,
                    );
                  },
                  child: const Text('Save Status'),
                ),
              ],
            );
          },
        );
      },
    );
    reasonController.dispose();
  }
}

class _ResponsiveDetailWrap extends StatelessWidget {
  final List<Widget> children;

  const _ResponsiveDetailWrap({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemWidth = width >= 1100
            ? (width - AppSpacing.lg * 2) / 3
            : width >= 700
                ? (width - AppSpacing.lg) / 2
                : width;

        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.sm,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;

  const _Pill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final String label;
  final String value;

  const _DetailTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textSecondary.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime value) => '${value.day}/${value.month}/${value.year}';
