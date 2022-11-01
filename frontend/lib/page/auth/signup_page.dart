import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/auth/signup_footer_widget.dart';
import 'package:frontend/page/auth/signup_form_widget.dart';
import 'package:frontend/page/auth/signup_header_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SignupHeaderWidget(),
                SignupFormWidget(),
                SignupFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
