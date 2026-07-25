import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repo.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repoimplemention.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/cubit/dashboard_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/repo/repo.dart';
import 'package:hossam_templete_for_apps/Feature/Dashboard/Logic/repo/repoimplementation.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/cubit/doctors_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repo.dart';
import 'package:hossam_templete_for_apps/Feature/Doctors/Logic/repo/repoimplementation.dart';
import 'package:hossam_templete_for_apps/Feature/cubit/main_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

void setupSL() {
  // Singletons (المكتبات والخدمات العامة)
  sl.registerSingleton<Prefs>(Prefs());
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Repositories (المستودعات)
  sl.registerLazySingleton<Repo>(
    () => Repoimplemention(supabase: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<DashboardRepo>(
    () => DashboardRepoImplementation(supabase: sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<DoctorRepo>(
    () => DoctorRepoImplementation(supabase: sl<SupabaseClient>()),
  );

  // Cubits / Blocs (متحكمات الحالة)
  sl.registerFactory(() => AuthCubit(sl<Repo>()));
  sl.registerFactory(() => DashboardCubit(sl<DashboardRepo>()));
  sl.registerFactory(() => DoctorsCubit(sl<DoctorRepo>()));
  sl.registerLazySingleton<MainCubit>(() => MainCubit());
}
