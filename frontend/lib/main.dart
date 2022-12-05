import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/size_config.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/page/navpage/main_page.dart'; // ignore: unused_import
import 'package:frontend/page/storefood/foodDetail/food_detail_observer.dart';
import 'page/openScreen/onboarding_screen.dart'; // ignore: unused_import
import 'package:bloc/bloc.dart'; // ignore: unused_import
import 'package:flutter_native_splash/flutter_native_splash.dart';
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

void main() async {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = FoodDetailObserver();
  await MongoDatabase.connect();

  // ------------------------ 本地通知設定
  // AndroidInitializationSettings androidSettings =
  //     const AndroidInitializationSettings("@mipmap/ic_launcher");

  // DarwinInitializationSettings iosSettings = const DarwinInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestCriticalPermission: true,
  //   requestSoundPermission: true,
  // );

  // InitializationSettings initializationSettings =
  //     InitializationSettings(android: androidSettings, iOS: iosSettings);

  // bool? initialized = await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  // );
  // log("Notifications: $initialized");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            title: 'Food_Battle_App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'GenJyuuGothic',
            ),
            home: const SplashPage(),
          );
        }

        // Main
        else {
          return MaterialApp(
            title: 'Food_Battle_App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'GenJyuuGothic',
            ),
            home: const OnboardingScreen(),
          );
        }
      },
    );
  }
}

// SplashPage
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/app_icon.png",
              height: SizeConfig.blockV! * 23,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "拯救食物大作戰",
              style: TextStyle(
                color: primaryColor7,
                fontFamily: chineseFontfamily,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
