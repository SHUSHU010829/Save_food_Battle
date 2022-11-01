import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/auth/login_page.dart';
import 'package:frontend/page/auth/signup_page.dart';
import 'package:frontend/page/navpage/main_page.dart';
import 'package:frontend/size_config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/icons/icon.png",
                height: SizeConfig.blockV! * 30,
              ),
              const SizedBox(
                height: 130,
              ),
              const Text(
                "食物拯救大作戰",
                style: TextStyle(
                  fontFamily: chineseFontfamily,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                " Save Food Battle",
                style: TextStyle(
                  fontFamily: englishFontfamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: secondary3,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: englishFontfamily,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        side: const BorderSide(width: 2, color: secondary3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: englishFontfamily,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: secondary3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              //* Google 登入按鈕
              // SignInButton(
              //   imagePosition: ImagePosition.left,
              //   buttonType: ButtonType.google,
              //   buttonSize: ButtonSize.medium,
              //   onPressed: () {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const MainPage(),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
