import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Core/utils/CustomWidgets/inputField.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Screens/DoctorDetailsScreen.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorListCard extends StatefulWidget {
  final List<DoctorModel> doctors;
  final String? selectedDoctorId;
  final ValueChanged<String> onDoctorSelected;

  const DoctorListCard({
    super.key,
    required this.doctors,
    required this.selectedDoctorId,
    required this.onDoctorSelected,
  });

  @override
  State<DoctorListCard> createState() => _DoctorListCardState();
}

class _DoctorListCardState extends State<DoctorListCard> {
  // دالة لإظهار dialog الرفض بشكل منفصل ونظيف
  void _showRejectDialog(BuildContext context, String doctorId) {
    final doctorsCubit = context.read<DoctorsCubit>();
    final TextEditingController reasonController = TextEditingController(
      text: "Rejected By Admin",
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "This doctor will be rejected. Are you sure?",
                style: TextStyle(
                  color: AppColors.error, // تعديل اللون إلى الأحمر للتنبيه
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  label: "Rejected Reason",
                  icon: Icons.wrap_text_outlined,
                  mycontroller: reasonController,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textSecondary,
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              doctorsCubit
                  .rejectDoctor(reasonController.text, doctorId: doctorId)
                  .then((value) {
                    Navigator.pop(dialogContext);
                  });
              // Navigator.pop(dialogContext);
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
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
            'Tap a doctor to view full details.',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.doctors.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final doctor = widget.doctors[index];
              final isSelected = doctor.id == widget.selectedDoctorId;

              return Material(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.08)
                    : AppColors.background,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => widget.onDoctorSelected(doctor.id),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
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
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                doctor.specialty ??
                                    doctor.email ??
                                    doctor.phone ??
                                    'No extra details',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.xs,
                            horizontal: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: doctor.profileCompleted
                                ? AppColors.success.withOpacity(0.12)
                                : AppColors.secondary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            doctor.profileCompleted ? 'Verified' : 'Pending',
                            style: TextStyle(
                              color: doctor.profileCompleted
                                  ? AppColors.success
                                  : AppColors.secondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (String value) async {
                            if (value == 'details') {
                              await context
                                  .read<DoctorsCubit>()
                                  .loadDoctorDetails(doctor.id);

                              if (!context.mounted) return;

                              final state = context.read<DoctorsCubit>().state;
                              if (state is DoctorsLoaded &&
                                  state.selectedDoctor != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Doctordetailsscreen(
                                      doctor: state.selectedDoctor!,
                                    ),
                                  ),
                                );
                              }
                            } else if (value == 'Approved') {
                              await context.read<DoctorsCubit>().approveDoctor(
                                doctorId: doctor.id,
                              );
                            } else if (value == 'Rejected') {
                              _showRejectDialog(context, doctor.id);
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem<String>(
                              value: 'details',
                              child: Row(
                                children: [
                                  Icon(Icons.visibility, size: 20),
                                  SizedBox(width: 8),
                                  Text('Details'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Approved',
                              child: Row(
                                children: [
                                  Icon(Icons.check, size: 20),
                                  SizedBox(width: 8),
                                  Text('Approved'),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<String>(
                              value: 'Rejected',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Rejected',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
