import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hossam_templete_for_apps/Core/Services/Interceptors.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/api_service.dart';
import 'package:hossam_templete_for_apps/Core/Services/dio_Consumer.dart';
import 'package:hossam_templete_for_apps/Core/constants/Endpoints.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/cubit/auth_cubit.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repo.dart';
import 'package:hossam_templete_for_apps/Feature/Auth/Logic/repo/repoimplemention.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
final sl = GetIt.instance; // sl تعني Service Locator

void setupSL() {
  // 1. تسجيل Dio كـ Singleton
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
      ),
    );

    // 2. إضافة الـ Interceptor الذي أنشأناه
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );

    // يمكنك أيضاً إضافة LogInterceptor لمشاهدة الطلبات في الـ Console
    dio.interceptors.add(LogInterceptor(responseBody: true));

    return dio;
  });

  // 3. بقية التسجيلات كما هي
  sl.registerLazySingleton<ApiService>(() => DioConsumer(dio: sl<Dio>()));
  sl.registerSingleton<Prefs>(Prefs());
  
   sl.registerLazySingleton<Repo>(
    () => Repoimplemention(apiService: sl<ApiService>()),
  );
  sl.registerFactory(() => AuthCubit(sl<Repo>()));
  

 }
