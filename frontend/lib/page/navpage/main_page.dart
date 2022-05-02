import 'package:flutter/material.dart';
import 'package:frontend/page/navpage/home_page.dart';
import 'package:frontend/page/navpage/scan_page.dart';
import 'package:frontend/page/navpage/setting_page.dart';
import 'package:frontend/page/navpage/storefood_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const ScanPage(),
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
      backgroundColor: const Color.fromRGBO(250, 249, 246, 1),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(250, 249, 246, 1),
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: const Color.fromRGBO(118, 139, 119, 1),
          unselectedItemColor: const Color.fromRGBO(177, 169, 169, 0.8),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.house_rounded,
                size: 28,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.document_scanner_rounded,
                size: 28,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.folder_copy_rounded,
                size: 28,
              ),
              label: 'Foodstore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                size: 28,
              ),
              label: 'Setting',
            ),
          ]),
    );
  }
}
