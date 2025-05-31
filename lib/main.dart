import 'package:emergency_one/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'features/auth/view/auth_view.dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency One',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: AuthViewDart(),
    );
  }
}
