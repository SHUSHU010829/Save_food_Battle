import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/size_config.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/welcome.png",
          height: SizeConfig.blockV! * 25,
        ),
        const Text(
          "Welcome Back,",
          style: TextStyle(
            fontFamily: englishFontfamily,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        const Text(
          "Login and enjoy!",
          style: TextStyle(
            fontFamily: englishFontfamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
