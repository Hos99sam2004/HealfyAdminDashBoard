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
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DoctorsError) {
          return Center(child: Text(state.message));
        }
        if (state is DoctorsLoaded ||
            state is DoctorsDetailLoading ||
            state is DoctorsDetailError) {
          DoctorsOverviewModel overview;

          DoctorDetailsModel? selectedDoctor;

          if (state is DoctorsLoaded) {
            overview = state.overview;
            selectedDoctor = state.selectedDoctor;
          } else if (state is DoctorsDetailLoading) {
            overview = state.overview;
            selectedDoctor = state.selectedDoctor;
          } else {
            overview = (state as DoctorsDetailError).overview;
            selectedDoctor = state.selectedDoctor;
          }

          return SingleChildScrollView(
            padding: AppSpacing.pagePadding(context),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                const SizedBox(height: AppSpacing.xl),

                DoctorStatsCard(statistics: overview.statistics),

                const SizedBox(height: AppSpacing.xl),

                DoctorListCard(
                  doctors: overview.doctors,

                  selectedDoctorId: selectedDoctor?.id,

                  onDoctorSelected: (id) =>
                      context.read<DoctorsCubit>().loadDoctorDetails(id),
                ),

                const SizedBox(height: AppSpacing.xl),

                if (selectedDoctor != null)
                  DoctorDetailCard(doctor: selectedDoctor),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
