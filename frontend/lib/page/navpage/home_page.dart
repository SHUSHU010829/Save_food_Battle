import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get mainAxisAlignment => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 249, 246, 1),
      body: Container(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/頭像.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    const Text(
                      "Hi,",
                      style: TextStyle(
                        color: Color.fromRGBO(27, 38, 42, 1),
                        fontFamily: 'GenJyuuGothic',
                        fontSize: 22,
                      ),
                    ),
                    const Text(
                      " User",
                      style: TextStyle(
                        color: Color.fromRGBO(27, 38, 42, 1),
                        fontFamily: 'GenJyuuGothic',
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "WALLETS",
              style: TextStyle(
                fontFamily: 'MontserratSubrayada',
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(91, 116, 98, 1),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(1, 4), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromRGBO(250, 249, 246, 1),
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,     
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "20,600",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Text(
                        "代繳: 0",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color.fromRGBO(148, 163, 144, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
