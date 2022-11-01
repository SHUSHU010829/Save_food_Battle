// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/auth/signup_page.dart';
import 'package:frontend/page/navpage/main_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  _signinWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final user = await googleSignIn.signIn();
      if (user != null) {
        print('User Name ' + user.displayName.toString());
        // if (user != null) {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const MainPage(),
        //     ),
        //   );
        // }
      } else {
        print('Sign in failed.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
            onPressed: _signinWithGoogle,
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
                builder: (context) => const SignupPage(),
              ),
            );
          },
          child: const Text.rich(
            TextSpan(
              text: 'Don\'t have an Account?',
              style: TextStyle(
                fontFamily: englishFontfamily,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: '  Sign up',
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
