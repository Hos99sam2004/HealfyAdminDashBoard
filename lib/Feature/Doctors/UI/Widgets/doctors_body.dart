import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctors_overview_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_detail_card.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_list_card.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Widgets/doctor_stats_card.dart';
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
        if (state is BulkApprovedError || state is BulkRejectedError) {
          final message = state is BulkApprovedError
              ? state.message
              : (state as BulkRejectedError).message;
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
                  if (selectedDoctor != null)
                    DoctorDetailCard(doctor: selectedDoctor!),
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
