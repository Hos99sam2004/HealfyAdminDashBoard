import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hossam_templete_for_apps/Core/Routes/go_router.dart';
import 'package:hossam_templete_for_apps/generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // key: ValueKey(cubit.locale.languageCode),
      // // locale: Locale(sl<Prefs>().getString('language_code') ?? 'en'),
      // locale: cubit.locale, // ✅ استخدم locale من Cubit
      locale: Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'MY App',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        // ✅ ScreenUtilInit جوا builder بعد ما localization اتحمل
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) => child!,
        );
      },
    );
  }
}
