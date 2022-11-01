// ignore_for_file: avoid_print, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_rounded),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondary3),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Email",
                fillColor: Colors.grey[200],
                filled: true,
              ),
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter email";
                }
                if (!value.contains('@')) {
                  return "Invalid email";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true, 
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint_rounded),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondary3),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Password",
                fillColor: Colors.grey[200],
                filled: true,
                // suffixIcon: IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.remove_red_eye_rounded),
                // ),
              ),
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forget Password?'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signin,
                child: const Text(
                  "LOG IN",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: englishFontfamily,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: secondary3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}