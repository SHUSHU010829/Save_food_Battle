// ignore_for_file: unused_local_variable, avoid_print, library_prefixes

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/dbModel/tobuy_model.dart';
import 'package:frontend/theme/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class TobuyWidget extends StatefulWidget {
  const TobuyWidget({Key? key}) : super(key: key);

  @override
  State<TobuyWidget> createState() => _TobuyWidgetState();
}

class _TobuyWidgetState extends State<TobuyWidget> {
  var titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor4,
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //* Bar + 新增按鈕
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shopping List",
                style: TextStyle(
                  fontFamily: englishSpecialFontfamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '加入購物車',
                              style: TextStyle(
                                fontFamily: chineseFontfamily,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: titleController,
                              maxLines: null,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondary6),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondary6),
                                ),
                                prefixIcon: Icon(
                                  Icons.title_rounded,
                                  color: secondary6,
                                ),
                                hintText: "食物品項名",
                                hintStyle: TextStyle(
                                  color: secondary3,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: chineseFontfamily,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Empty!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          final isValidForm = formKey.currentState!.validate();
                          if (isValidForm) {
                            _insertData(titleController.text.trim());
                          }
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          primary: secondary6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: secondary3,
                            fontWeight: FontWeight.w700,
                            fontFamily: chineseFontfamily,
                          ),
                        ),
                        child: const Text('Insert'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          //* Display
          // ignore: todo
          //TODO: 卡片滑動時沒辦法停在底部
          SizedBox(
            height: 260, // Some height
            child: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: MediaQuery.removePadding(
                  //消除頂部空白
                  context: context,
                  removeTop: true,
                  child: FutureBuilder(
                    future: MongoDatabase().getTobuyData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          var totalData = snapshot.data.length;
                          if (totalData == 0) {
                            return const Center(
                              child: Text("目前購物清單是空的！"),
                            );
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, _) =>
                                const SizedBox(width: 12),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => displayCard(
                              TobuyModel.fromJson(snapshot.data[index]),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text("重整連接資料庫！"),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    setState(() {});
  }

  //輸入數值
  Future<void> _insertData(String title) async {
    // print(user.uid);
    var _id = M.ObjectId();
    final data = TobuyModel(
      uid: user!.uid.toString(),
      id: _id,
      title: title,
    );
    var result = await MongoDatabase.toBuyInsert(data)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("匯入成功！"),
      ),
    );
    _clearAll();
  }

  //清空數值
  void _clearAll() {
    titleController.text = "";
  }

  // 顯示卡片
  Widget displayCard(TobuyModel data) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: 60,
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor9,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: secondary2,
              boxShadow: const [
                BoxShadow(
                  color: primaryColor2,
                  offset: Offset(3.0, 3.0),
                  blurRadius: 5, //陰影模糊程度
                  spreadRadius: 0, //陰影擴散程度
                ),
              ],
            ),
            child: Row(
              children: [
                // ignore: todo
                //TODO TodoList 刪除動畫
                IconButton(
                  onPressed: () {
                    print(data.id);
                    MongoDatabase.deleteTobuy(data);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_rounded),
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: 144,
                  child: Text(
                    data.title,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: englishFontfamily,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      );
}
