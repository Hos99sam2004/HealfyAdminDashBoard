import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // هنا نجلب التوكن (مثلاً من SharedPreferences أو Secure Storage)
    final Prefs prefs = sl<Prefs>();
    String? token = prefs.getString('auth_token');
    log("AuthInterceptor: Retrieved token: $token");

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print("Sending request to: ${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // هنا يمكنك توجيه المستخدم لصفحة تسجيل الدخول تلقائياً
      print("Token expired!");
    }
    return super.onError(err, handler);
  }
}
