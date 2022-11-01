import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/auth/login_page.dart';

class SignupFooterWidget extends StatelessWidget {
  const SignupFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('OR'),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            label: const Text(
              'Sign In With Google',
              style: TextStyle(
                color: textColor,
                fontFamily: englishFontfamily,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            style: OutlinedButton.styleFrom(
              primary: textColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              side: const BorderSide(width: 1, color: Colors.black),
            ),
            icon: const FaIcon(FontAwesomeIcons.google, color: secondary3),
            onPressed: () {},
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: const Text.rich(
            TextSpan(
              text: 'Already have an Account?',
              style: TextStyle(
                fontFamily: englishFontfamily,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: '  Log in',
                  style: TextStyle(
                    color: secondary4,
                    fontFamily: englishFontfamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
