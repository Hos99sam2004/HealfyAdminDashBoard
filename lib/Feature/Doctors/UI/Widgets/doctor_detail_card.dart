import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_documents_section.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorDetailCard extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const DoctorDetailCard({super.key, required this.doctor});

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
      child: SingleChildScrollView(
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
                        doctor.specialty ?? doctor.role ?? 'Doctor',
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
                          _Pill(
                            label: doctor.status?.toUpperCase() ?? 'PENDING',
                          ),
                          _Pill(label: '${doctor.rating ?? 1000}/5 Rating'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                _StatusChip(doctor: doctor),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.sm,
              children: [
                _DetailTile(
                  label: 'Email',
                  value: doctor.email ?? 'Not available',
                ),
                _DetailTile(
                  label: 'Phone',
                  value: doctor.phone ?? 'Not available',
                ),
                _DetailTile(
                  label: 'Clinic',
                  value: doctor.clinicName ?? 'Not available',
                ),
                _DetailTile(
                  label: 'City',
                  value: doctor.city ?? 'Not available',
                ),
                _DetailTile(
                  label: 'License',
                  value: doctor.licenseNumber ?? 'Not available',
                ),
                _DetailTile(
                  label: 'Experience',
                  value: '${doctor.yearsExperience ?? 0} years',
                ),
                _DetailTile(
                  label: 'Price',
                  value: doctor.consultationPrice != null
                      ? '\$${doctor.consultationPrice!.toStringAsFixed(0)}'
                      : 'Not available',
                ),
                _DetailTile(
                  label: 'created',
                  value: doctor.joinedAt != null
                      ? _formatDate(doctor.joinedAt!)
                      : 'Not available',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionHeader(title: 'Professional Information'),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                _DetailTile(
                  label: 'Specialty',
                  value: doctor.specialty ?? 'Not available',
                ),
                _DetailTile(
                  label: 'Verification',
                  value: doctor.status ?? 'Pending',
                ),
                _DetailTile(
                  label: 'Reviews',
                  value: '${doctor.totalReviews ?? 1000}',
                ),
                _DetailTile(
                  label: 'Completion',
                  value: '${doctor.profileCompletionPercent ?? 1000}%',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionHeader(title: 'About'),
            const SizedBox(height: AppSpacing.sm),
            Text(
              doctor.bio ?? 'No biography available.',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionHeader(title: 'Working Days'),
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
            const SizedBox(height: AppSpacing.lg),
            if (doctor.verificationReason != null &&
                doctor.verificationReason!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Verification Note'),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    doctor.verificationReason!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final DoctorDetailsModel doctor;

  const _StatusChip({required this.doctor});

  @override
  Widget build(BuildContext context) {
    final isVerified = (doctor.status ?? '').toLowerCase() == 'approved';
    print(isVerified);
    print(doctor.profileCompleted);
    final color = isVerified ? AppColors.success : AppColors.secondary;
    print(Color(color.value));
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
        doctor.profileCompleted ? 'Verified' : 'Pending',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
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
      constraints: const BoxConstraints(minWidth: 160),
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

String _formatDate(DateTime value) {
  return '${value.day}/${value.month}/${value.year}';
}
