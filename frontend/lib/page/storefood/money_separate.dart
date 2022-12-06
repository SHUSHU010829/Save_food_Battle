import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';

class MoneySeparatePage extends StatefulWidget {
  const MoneySeparatePage({Key? key}) : super(key: key);

  @override
  State<MoneySeparatePage> createState() => _MoneySeparatePageState();
}

class _MoneySeparatePageState extends State<MoneySeparatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* BAR
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 64, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "多人分配食材",
                    style: TextStyle(
                      fontSize: 31,
                      fontWeight: FontWeight.w700,
                      fontFamily: chineseFontfamily,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            //* 份量框
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor9,
                    width: 2,
                  ),
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "總份量",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        "8",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: englishFontfamily,
                          color: textColor,
                        ),
                      ),
                      const Text(
                        "盒",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                      const Text(
                        "Box(s)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: englishFontfamily,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Container(
                        color: Colors.black45,
                        height: 50,
                        width: 2,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      const Text(
                        "未完成分配",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        "0",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: englishFontfamily,
                          color: textColor,
                        ),
                      ),
                      const Text(
                        "盒",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: chineseFontfamily,
                          color: textColor,
                        ),
                      ),
                      const Text(
                        "Box(s)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: englishFontfamily,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ignore: todo
            //TODO 下拉選單選取房間名
            //* Room Title
            const Padding(
              padding: EdgeInsets.only(left: 54, top: 20),
              child: Text(
                "Room 1",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: englishFontfamily,
                  color: textColor,
                ),
              ),
            ),
            //* 用戶卡片
            userNumCard(),
            userNumCard(),
            userNumCard(),
            userNumCard(),
            Padding(
              padding: const EdgeInsets.all(54.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("開發中 ⸜(๑˙ᵕ ˙๑)⸝ "),
                    style: ElevatedButton.styleFrom(
                      primary: secondary4,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: secondary3,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userNumCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 62, top: 20, right: 62),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor9,
            width: 2,
          ),
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/頭像.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Shu",
                    style: TextStyle(
                      color: primaryColor9,
                      fontFamily: englishFontfamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 32,
                      color: primaryColor4,
                    ),
                  ),
                  const Text(
                    '2',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontFamily: englishFontfamily,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 32,
                      color: primaryColor4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
