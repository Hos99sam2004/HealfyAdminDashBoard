import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/Routes/go_router.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/theme/app_theme.dart';
import 'package:hossam_templete_for_apps/Feature/cubit/main_cubit.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MainCubit>(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final cubit = context.watch<MainCubit>();

          return ScreenUtilInit(
            // Use a desktop-first design canvas so .sp/.w/.h remain usable
            // only in legacy mobile widgets (Onboarding, Auth) that still
            // reference ScreenUtil. All new responsive widgets use MediaQuery.
            designSize: const Size(1440, 900),
            minTextAdapt: false,
            splitScreenMode: false,
            builder: (_, __) => MaterialApp.router(
              key: ValueKey(
                '${cubit.locale.languageCode}-${cubit.themeMode.name}-${cubit.appColorName}',
              ),
              locale: cubit.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              title: 'Healfy Admin',
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: cubit.themeMode,
            ),
          );
        },
      ),
    );
  }
}
