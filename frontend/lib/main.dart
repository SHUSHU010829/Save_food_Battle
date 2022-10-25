import 'package:flutter/material.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/page/navpage/main_page.dart'; // ignore: unused_import
import 'package:frontend/page/storefood/foodDetail/food_detail_observer.dart';
import 'package:get/get.dart';
import 'page/openScreen/onboarding_screen.dart'; // ignore: unused_import
import 'package:bloc/bloc.dart'; // ignore: unused_import
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
//CameraDescription? camera;

//List<CameraDescription> cameras = [];
void main() async {
  Bloc.observer = FoodDetailObserver();
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  await MongoDatabase.connect();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food_Battle_App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GenJyuuGothic',
      ),
      home: const OnboardingScreen(),
    );
  }
}
