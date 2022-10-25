//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/page/navpage/home_page.dart';
import 'package:frontend/page/navpage/identity_page.dart';
import 'package:frontend/page/navpage/scan_page.dart';
import 'package:frontend/page/navpage/setting_page.dart';
import 'package:frontend/page/navpage/storefood_page.dart';

//List<CameraDescription>? cameras;
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const ScanPage(),
    const IdentityPage(),
    const StorefoodPage(),
    const SettingPage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: primaryColor5,
        unselectedItemColor: textColor2,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 32,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner_rounded,
              size: 32,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.flip_rounded,
              size: 32,
            ),
            label: 'Identity',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.folder_copy_rounded,
              size: 32,
            ),
            label: 'Foodstore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_rounded,
              size: 32,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
