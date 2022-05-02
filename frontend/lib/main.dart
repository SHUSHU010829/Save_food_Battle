import 'package:flutter/material.dart';
import 'package:frontend/page/navpage/main_page.dart'; // ignore: unused_import
import 'screen/onboarding_screen.dart'; // ignore: unused_import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food_Battle_App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GenJyuuGothic',
      ),
      home: const OnboardingScreen(),
    );
  }
}
