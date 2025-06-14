import 'package:emergency_one/core/routes/app_pages.dart';
import 'package:emergency_one/core/themes/themes.dart';
import 'package:emergency_one/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/auth/view/login_view.dart';
import 'features/splace/view/splace_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Emergency One',
      theme: lightTheme,
      getPages: pageRoutes,
      themeMode: ThemeMode.light,
      darkTheme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplaceView(),
    );
  }
}
