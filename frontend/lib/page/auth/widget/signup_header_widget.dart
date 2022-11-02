import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/size_config.dart';

class SignupHeaderWidget extends StatelessWidget {
  const SignupHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/signup.png",
          height: SizeConfig.blockV! * 15,
        ),
        const Text(
          "First time see you.",
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
          "Signup and enjoy!",
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
