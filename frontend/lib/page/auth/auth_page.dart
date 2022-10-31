import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/navpage/main_page.dart';
import 'package:frontend/size_config.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/icon.png",
                height: SizeConfig.blockV! * 30,
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontFamily: chineseFontfamily,
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "食物拯救大作戰",
                style: TextStyle(
                  fontFamily: chineseFontfamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              //* Google 登入按鈕
              SignInButton(
                imagePosition: ImagePosition.left,
                buttonType: ButtonType.google,
                buttonSize: ButtonSize.medium,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
