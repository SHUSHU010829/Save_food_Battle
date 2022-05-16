import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

import '../../size_config.dart';

class FoodScan extends StatefulWidget {
  final Function toggleView;
  const FoodScan({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<FoodScan> createState() => _FoodScanPageState();
}

class _FoodScanPageState extends State<FoodScan> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: primaryColor2,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 5,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.defaultSize! * 3,
                        right: SizeConfig.defaultSize! * 3),
                    child: Form(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: SizeConfig.defaultSize! * 20),
                        padding: EdgeInsets.only(
                            top: SizeConfig.defaultSize! * 6,
                            bottom: SizeConfig.defaultSize! * 2,
                            left: SizeConfig.defaultSize! * 2,
                            right: SizeConfig.defaultSize! * 2),
                        height: SizeConfig.defaultSize! * 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: primaryColor2),
                                prefixIcon: Icon(
                                  Icons.mail,
                                  size: SizeConfig.defaultSize! * 2,
                                  color: primaryColor2,
                                ),
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: primaryColor2)),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 2,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(color: primaryColor2),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: SizeConfig.defaultSize! * 2,
                                  color: primaryColor2,
                                ),
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: primaryColor2)),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 2,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Fullname',
                                labelStyle:
                                    const TextStyle(color: primaryColor2),
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: SizeConfig.defaultSize! * 2,
                                  color: primaryColor2,
                                ),
                                filled: true,
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: primaryColor2)),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 2,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: const Text(
                                  'Forgot your password?',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onTap: () {},
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 2,
                            ),
                            ButtonTheme(
                              height: SizeConfig.defaultSize! * 5,
                              minWidth: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: primaryColor2,
                                hoverColor: textColor,
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize! * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Have an account? ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.toggleView();
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: primaryColor2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: SizeConfig.defaultSize! * 17),
                    height: SizeConfig.defaultSize! * 5,
                    width: SizeConfig.defaultSize! * 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 6,
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Jobseeker App',
                        style: TextStyle(
                            color: primaryColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
