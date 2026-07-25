import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/Core/constants/Endpoints.dart';
import 'package:hossam_templete_for_apps/MyAPP.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: EndPoints.supabase_BaseUrl,
    anonKey: EndPoints.anonKey,
  );

  setupSL();
  await sl<Prefs>().init();
  runApp(const MyApp());
}
