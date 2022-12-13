import 'package:flutter/material.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/dbModel/user_allstorefood_model.dart';

class SearchFoodPage extends StatefulWidget {
  const SearchFoodPage({Key? key}) : super(key: key);

  @override
  State<SearchFoodPage> createState() => _SearchFoodPageState();
}

class _SearchFoodPageState extends State<SearchFoodPage> {
  var titleController = TextEditingController();
  var keyWord = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor3,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "搜尋你的食材",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: chineseFontfamily,
            color: secondary2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:24.0, bottom: 4.0, left: 24.0, right:24.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    onChanged: (text) {
                      setState(() {
                        keyWord = text;
                      });
                    },
                    style: const TextStyle(color: secondary3),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: secondary5,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Eg. Apple",
                      hintStyle: const TextStyle(
                        color: secondary2,
                        fontWeight: FontWeight.w600,
                        fontFamily: englishFontfamily,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: secondary3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "--------------------------------------",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: chineseFontfamily,
                color: secondary3,
              ),
            ),
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
          ],
        ),
      ),
    );
  }

  Widget displayData(UserMongoDbModel data) => Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
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
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 12.0, right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* title
                  Row(
                    children: [
                      Text(
                        data.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: chineseFontfamily,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      //* 存放地點
                      Container(
                        alignment: Alignment.center, // 內裝元件置中對齊
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: secondary6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
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
                      const SizedBox(
                        width: 12,
                      ),
                      //* 有效日期
                      Container(
                        alignment: Alignment.center, // 內裝元件置中對齊
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: secondary5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                          child: Center(
                            child: Text(
                              "# ${data.year}-${data.month}-${data.day}",
                              style: const TextStyle(
                                fontSize: 15,
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
          ),
        ),
      );
}
