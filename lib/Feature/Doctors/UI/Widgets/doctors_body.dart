import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_detail_card.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_list_card.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_stats_card.dart';
import 'package:hossam_templete_for_apps/theme/app_colors.dart';
import 'package:hossam_templete_for_apps/theme/app_spacing.dart';

class DoctorsBody extends StatefulWidget {
  const DoctorsBody({super.key});

  @override
  State<DoctorsBody> createState() => _DoctorsBodyState();
}

class _DoctorsBodyState extends State<DoctorsBody> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorsCubit>().loadDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorsCubit, DoctorsState>(
      listener: (context, state) {
        if (state is BulkApprovedError ||
            state is BulkRejectedError ||
            state is DoctorStatusChangeError) {
          final message = state is BulkApprovedError
              ? state.message
              : state is BulkRejectedError
                  ? state.message
                  : (state as DoctorStatusChangeError).message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      },
      builder: (context, state) {
        if (state is DoctorsLoading || state is DoctorsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorsError) {
          return Center(child: Text(state.message));
        }

        DoctorsOverviewModel? overview;
        DoctorDetailsModel? selectedDoctor;
        var isActionLoading = false;
        var isDetailLoading = false;

        if (state is DoctorsLoaded) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is DoctorsDetailLoading) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
          isDetailLoading = true;
        } else if (state is DoctorsDetailError) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is BulkApprovedLoading) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
          isActionLoading = true;
        } else if (state is BulkApprovedError) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is BulkApprovedSuccess) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is BulkRejectedLoading) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
          isActionLoading = true;
        } else if (state is BulkRejectedError) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is BulkRejectedSuccess) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is DoctorStatusChangeLoading) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
          isActionLoading = true;
        } else if (state is DoctorStatusChangeError) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        } else if (state is DoctorStatusChangeSuccess) {
          overview = state.overview;
          selectedDoctor = state.selectedDoctor;
        }

        if (overview == null) return const SizedBox.shrink();

        return Stack(
          children: [
            SingleChildScrollView(
              padding: AppSpacing.pagePadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xl),
                  DoctorStatsCard(statistics: overview!.statistics),
                  const SizedBox(height: AppSpacing.xl),
                  DoctorListCard(
                    doctors: overview!.doctors,
                    selectedDoctorId: selectedDoctor?.id,
                    onDoctorSelected: (id) =>
                        context.read<DoctorsCubit>().loadDoctorDetails(id),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  if (selectedDoctor != null) ...[
                    DoctorDetailCard(doctor: selectedDoctor!),
                    const SizedBox(height: AppSpacing.md),
                    _DoctorStatusActions(
                      doctor: selectedDoctor!,
                      isLoading: isActionLoading,
                    ),
                    if (selectedDoctor!.status?.toLowerCase() == 'pending') ...[
                      const SizedBox(height: AppSpacing.md),
                      _DoctorVerificationActions(
                        doctor: selectedDoctor!,
                        isLoading: isActionLoading,
                      ),
                    ],
                  ],
                ],
              ),
            ),
            if (isActionLoading || isDetailLoading)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}

class _DoctorStatusActions extends StatelessWidget {
  final DoctorDetailsModel doctor;
  final bool isLoading;

  const _DoctorStatusActions({required this.doctor, required this.isLoading});

  Future<void> _showChangeStatusDialog(BuildContext context) async {
    var selectedStatus = doctor.status?.toLowerCase() ?? 'pending';
    final reasonController = TextEditingController(
      text: doctor.status?.toLowerCase() == 'rejected'
          ? doctor.verificationReason ?? ''
          : '',
    );

    final result = await showDialog<_StatusChangeResult>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            final needsReason = selectedStatus == 'rejected';
            return AlertDialog(
              title: const Text('Change Doctor Status'),
              content: SizedBox(
                width: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'pending',
                          child: Text('Pending'),
                        ),
                        DropdownMenuItem(
                          value: 'approved',
                          child: Text('Approved'),
                        ),
                        DropdownMenuItem(
                          value: 'rejected',
                          child: Text('Rejected'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedStatus = value);
                        }
                      },
                    ),
                    if (needsReason) ...[
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: reasonController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Rejection reason',
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
                    final reason = reasonController.text.trim();
                    if (needsReason && reason.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a rejection reason.'),
                        ),
                      );
                      return;
                    }
                    Navigator.of(dialogContext).pop(
                      _StatusChangeResult(
                        status: selectedStatus,
                        reason: needsReason ? reason : null,
                      ),
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

    if (!context.mounted || result == null) return;

    await context.read<DoctorsCubit>().changeDoctorStatus(
          doctorId: doctor.id,
          status: result.status,
          reason: result.reason,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding(context),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.manage_accounts_outlined),
          const SizedBox(width: AppSpacing.sm),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Doctor Status',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  'Change the doctor verification status.',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: isLoading
                ? null
                : () => _showChangeStatusDialog(context),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Change Status'),
          ),
        ],
      ),
    );
  }
}

class _StatusChangeResult {
  final String status;
  final String? reason;

  const _StatusChangeResult({required this.status, this.reason});
}

class _DoctorVerificationActions extends StatelessWidget {
  final DoctorDetailsModel doctor;
  final bool isLoading;

  const _DoctorVerificationActions({
    required this.doctor,
    required this.isLoading,
  });

  Future<void> _showRejectDialog(BuildContext context) async {
    final controller = TextEditingController();
    final reason = await showDialog<String?>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reject Doctor'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 4,
            textInputAction: TextInputAction.newline,
            decoration: const InputDecoration(
              labelText: 'Rejection reason',
              hintText: 'Enter the reason for rejecting this doctor',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(controller.text.trim());
              },
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
    controller.dispose();

    if (!context.mounted || reason == null) return;

    context.read<DoctorsCubit>().rejectDoctor(
          reason.isEmpty ? null : reason,
          doctorId: doctor.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding(context),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textSecondary.withOpacity(0.08),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.end,
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          OutlinedButton.icon(
            onPressed: isLoading ? null : () => _showRejectDialog(context),
            icon: const Icon(Icons.close),
            label: const Text('Reject'),
          ),
          FilledButton.icon(
            onPressed: isLoading
                ? null
                : () => context.read<DoctorsCubit>().approveDoctor(
                      doctorId: doctor.id,
                    ),
            icon: const Icon(Icons.check),
            label: const Text('Approve'),
          ),
        ],
      ),
    );
  }
}
