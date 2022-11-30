// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/scanpage/food_detail_page.dart';

//TODO 刪除卡片
class EditFoodPage extends StatefulWidget {
  const EditFoodPage({Key? key}) : super(key: key);

  @override
  State<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  var titleController = TextEditingController();
  var keyWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "匯入編輯",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            //* 搜尋 Bar
            TextFormField(
              controller: titleController,
              maxLines: null,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                setState(() {
                  keyWord = text;
                });
              },
              cursorColor: Colors.grey,
              style: const TextStyle(color: secondary3),
              decoration: InputDecoration(
                filled: true,
                fillColor: secondary5,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: ' Search',
                hintStyle: const TextStyle(
                  color: secondary2,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: englishFontfamily,
                ),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Icon(
                    Icons.search_rounded,
                    size: 28,
                    color: secondary2,
                  ),
                  width: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            //* 食物卡
            SizedBox(
              height: 550,
              child: FutureBuilder(
                future: MongoDatabase().getQueryData(keyWord),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return const Center(
                          child: Text('沒有這樣食物喔！'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayData(
                              UserMongoDbModel.fromJson(snapshot.data[index]),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: Text('錯誤！'),
                      );
                    }
                  }
                },
              ),
            ),
            //* 底部兩顆按鈕
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "匯入倉庫",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: primaryColor5,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "重新掃描",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: chineseFontfamily,
                        color: textColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
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

  Widget displayData(UserMongoDbModel data) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const EditDetailPage();
                    },
                    settings: RouteSettings(arguments: data)))
            .then((value) {
          setState(() {});
        }),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
          ),
          child: SizedBox(
            height: 70,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor9,
                  width: 2,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                boxShadow: const [
                  BoxShadow(
                    color: primaryColor2,
                    offset: Offset(6.0, 6.0), //陰影x軸偏移量
                    blurRadius: 5, //陰影模糊程度
                    spreadRadius: 0, //陰影擴散程度
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    data.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: englishFontfamily,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  //* 份數
                                  Container(
                                    alignment: Alignment.center, // 內裝元件置中對齊
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: secondary5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 1.0,
                                        bottom: 1.0,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "# ${data.count}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: textColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: englishFontfamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  //* 存放地點
                                  Container(
                                    alignment: Alignment.center, // 內裝元件置中對齊
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: secondary6,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 1.0,
                                          bottom: 1.0),
                                      child: Center(
                                        child: Text(
                                          "# ${data.place}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: textColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: englishFontfamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
