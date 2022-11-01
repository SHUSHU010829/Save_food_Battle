// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _comfirmPasswordController = TextEditingController();

  Future signUp() async {
    // authenicate user
    if (passwordComfirm()) {
      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // add user details
      addUserDetails(
        _nameController.text.trim(),
        _emailController.text.trim(),
      );
    }
  }

  Future addUserDetails(String name, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'userName': name,
      'email': email,
    });
  }

  bool passwordComfirm() {
    if (_passwordController.text.trim() ==
        _comfirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _comfirmPasswordController.dispose();
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
              keyboardType: TextInputType.text,
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
                hintText: "UserName",
                fillColor: Colors.grey[200],
                filled: true,
              ),
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
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
                hintText: "Comfirm Password",
                fillColor: Colors.grey[200],
                filled: true,
                // suffixIcon: IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.remove_red_eye_rounded),
                // ),
              ),
              controller: _comfirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter password";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: signUp,
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
