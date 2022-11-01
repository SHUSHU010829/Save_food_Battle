import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class SignupFormWidget extends StatelessWidget {
  const SignupFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  labelText: "UserName",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  labelText: "Email",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint_rounded),
                labelText: "Password ",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_rounded),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
