import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/page/navpage/main_page.dart'; // ignore: unused_import
import 'package:frontend/page/storefood/foodDetail/food_detail_observer.dart';
import 'page/openScreen/onboarding_screen.dart'; // ignore: unused_import
import 'package:bloc/bloc.dart'; // ignore: unused_import

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
  Bloc.observer = FoodDetailObserver();
  await MongoDatabase.connect();

  WidgetsFlutterBinding.ensureInitialized();

  AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings("app_icon");

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings, iOS: initializationSettingsDarwin);

  bool? initialized = await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  log("Notifications: $initialized");

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
