import 'package:flutter/material.dart';
import 'package:hossam_templete_for_apps/Core/Services/Prefs.dart';
import 'package:hossam_templete_for_apps/Core/Services/service_locator.dart';
import 'package:hossam_templete_for_apps/MyAPP.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();

  // await Hive.initFlutter();
 


  setupSL(); // Initialize the service locator before running the app
  await sl<Prefs>().init();
  runApp(const MyApp());
}
