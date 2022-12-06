import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/page/auth/login_page.dart';
import 'package:frontend/page/auth/signup_page.dart';
import 'package:frontend/page/navpage/main_page.dart';
import 'package:frontend/theme/size_config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreen);
    } else {
      return SignupPage(showLoginPage: toggleScreen);
    }
  }
}
