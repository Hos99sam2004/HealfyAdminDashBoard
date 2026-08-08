import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/models/doctor_details_model.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/UI/Screens/DoctorDetailsScreen.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hossam_templete_for_apps/Core/Routes/Routes.dart';
import 'package:hossam_templete_for_apps/Feature/Search/Logic/cubit/patient_search_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Search/Logic/cubit/patient_search_state.dart';

class PatientSearchScreen extends StatefulWidget {
  const PatientSearchScreen({super.key});

  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
  DoctorDetailsModel? doctorDetailsModel;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PatientSearchCubit>().initSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20.sp,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onSubmitted: (query) =>
              context.read<PatientSearchCubit>().search(query),
          decoration: InputDecoration(
            hintText: 'Search doctor, specialty...',
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          style: TextStyle(fontSize: 16.sp, color: colorScheme.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              _searchController.clear();
              context.read<PatientSearchCubit>().search('');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune_rounded, color: colorScheme.primary),
            onPressed: () {
              // context.push(Routes.filter);
            },
          ),
        ],
      ),
      body: BlocBuilder<PatientSearchCubit, PatientSearchState>(
        builder: (context, state) {
          if (state is PatientSearchLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (state is PatientSearchSuccess) {
            if (state.currentQuery.isEmpty) {
              return _buildRecentSearches(
                context,
                state.recentSearches,
                colorScheme,
              );
            }

            if (state.results.isEmpty) {
              return _buildEmptyState(colorScheme, state.currentQuery);
            }

            return ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: state.results.length,
              separatorBuilder: (_, __) => SizedBox(height: 14.h),
              itemBuilder: (context, index) {
                final doctor = state.results[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  tileColor: colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  leading: CircleAvatar(
                    radius: 24.r,
                    backgroundColor: colorScheme.primaryContainer,
                    backgroundImage: doctor.avatarUrl != null
                        ? NetworkImage(doctor.avatarUrl!)
                        : null,
                    child: doctor.avatarUrl == null
                        ? Icon(Icons.person, color: colorScheme.primary)
                        : null,
                  ),
                  title: Text(
                    'Dr. ${doctor.fullName}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    '${doctor.specialtyName} • ⭐ ${doctor.rating.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              sl<DoctorsCubit>()..loadDoctorDetails(doctor.id),
                          child: BlocBuilder<DoctorsCubit, DoctorsState>(
                            builder: (context, state) {
                              if (state is DoctorsDetailLoading) {
                                return const Scaffold(
                                  body: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (state is DoctorsLoaded) {
                                return Doctordetailsscreen(
                                  doctor: state.selectedDoctor!,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRecentSearches(
    BuildContext context,
    List<String> recents,
    ColorScheme colorScheme,
  ) {
    if (recents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_rounded,
              size: 64.sp,
              color: colorScheme.outlineVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              'Search for doctors, specialties or clinics',
              style: TextStyle(
                fontSize: 15.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () =>
                    context.read<PatientSearchCubit>().clearHistory(),
                child: Text(
                  'Clear All',
                  style: TextStyle(fontSize: 14.sp, color: colorScheme.error),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: recents.map((item) {
              return ActionChip(
                label: Text(item),
                avatar: Icon(
                  Icons.history_rounded,
                  size: 16.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onPressed: () {
                  _searchController.text = item;
                  context.read<PatientSearchCubit>().search(item);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, String query) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.sp,
            color: colorScheme.outlineVariant,
          ),
          SizedBox(height: 16.h),
          Text(
            'No results found for "$query"',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try checking spelling or filter by specialty',
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
