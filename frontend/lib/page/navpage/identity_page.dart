// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/main.dart';

int id = 0;

class IdentityPage extends StatefulWidget {
  const IdentityPage({Key? key}) : super(key: key);

  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await _showNotification();
      //   },
      //   child: const Icon(Icons.notification_add_rounded),
      // ),
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            //* BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Food Identity",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "實景掃描",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
