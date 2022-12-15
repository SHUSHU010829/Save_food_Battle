import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/page/openScreen/onboarding_screen.dart';
import 'package:frontend/theme/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffede9e3),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/icons/app_icon.png"),
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "拯救食物大作戰",
              style: TextStyle(
                color: primaryColor7,
                fontFamily: chineseFontfamily,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SpinKitThreeBounce(
              color: primaryColor1,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
