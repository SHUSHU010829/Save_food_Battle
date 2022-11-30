import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/user_allstorefood_model.dart';

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
        backgroundColor: secondary3,
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
              padding: const EdgeInsets.all(24.0),
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
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.brown[900],
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
            const SizedBox(
              height: 16,
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
        child: Container(
          height: 80,
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
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
                                const SizedBox(
                                  width: 8,
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
      );
}
