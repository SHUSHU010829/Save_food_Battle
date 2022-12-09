import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/alertFood_model.dart';
import 'package:frontend/models/scanQRmodel.dart';
import 'package:frontend/models/user_allstorefood_model.dart';
import 'package:frontend/page/storefood/money_separate.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

// ignore: must_be_immutable
class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final formKey = GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();

  List<String> items = ['肉類', '蛋', '豆', '魚', '水果'];

  String foodType = '肉類';
  String storePlace = '';

  var titleController = TextEditingController();
  var countController = TextEditingController();
  var splaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScanQrModel? data =
        ModalRoute.of(context)!.settings.arguments as ScanQrModel?;
    if (data != null) {
      titleController.text = data.name;
      countController.text = data.count;
      // storePlace = data.place;
      // foodType = data.foodType;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 28,
                ),
                //* BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Insert",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        fontFamily: englishFontfamily,
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
                //* Title
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
                              maxLines: null,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'FoodTitle',
                                hintStyle: TextStyle(
                                  color: primaryColor1,
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
                            const Divider(color: Colors.black)
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.drive_file_rename_outline_rounded,
                        color: secondary4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //* 存放地點
                const Text(
                  "存放地點",
                  style: TextStyle(
                    fontFamily: chineseFontfamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                placeCard(),
                //* 有效日期
                const Text(
                  "有效日期",
                  style: TextStyle(
                    fontFamily: chineseFontfamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                StatefulBuilder(
                  builder: (context, state) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 4.0,
                            primary: primaryColor1,
                          ),
                          onPressed: () async {
                            DateTime? _newDate = await showDatePicker(
                              context: context,
                              initialDate: _dateTime,
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 10),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme(
                                      // uses the brightness of the user (Light or Dark)
                                      brightness: Brightness.light,
                                      primary: primaryColor7,
                                      onPrimary: primaryColor1,
                                      secondary: secondary1,
                                      onSecondary: secondary1,
                                      error: secondary6,
                                      onError: secondary1,
                                      background: primaryColor1,
                                      onBackground: primaryColor1,
                                      surface: secondary1,
                                      onSurface: secondary4,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: secondary6,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (_newDate != null) {
                              state(() {
                                _dateTime = _newDate;
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Text(
                                '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}',
                                style: const TextStyle(
                                  fontFamily: englishFontfamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //* 數量 & 百分比
                countSlide(),
                const SizedBox(
                  height: 8,
                ),
                //* 類別
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "類別",
                      style: TextStyle(
                        fontFamily: chineseFontfamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    foodTypeDropdown(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //* 底部按鈕
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: OutlinedButton(
                          child: const Text(
                            '分配食材',
                            style: TextStyle(
                              color: textColor,
                              fontFamily: chineseFontfamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            primary: textColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const MoneySeparatePage();
                                },
                                settings: const RouteSettings(arguments: null),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final isValidForm = formKey.currentState!.validate();
                          String d, m;
                          if (isValidForm) {
                            if (_dateTime.day < 10 && _dateTime.day > 0) {
                              d = '0${_dateTime.day}';
                            } else {
                              d = '${_dateTime.day}';
                            }
                            if (_dateTime.month < 10 && _dateTime.month > 0) {
                              m = '0${_dateTime.month}';
                            } else {
                              m = '${_dateTime.month}';
                            }
                            _insertData(
                              titleController.text.trim(),
                              _dateTime.year.toString(),
                              m,
                              d,
                              countController.text.trim(),
                              storePlace.toString().trim(),
                              foodType.trim(),
                              "100",
                            );
                          }
                        },
                        child: const Text("確認輸入"),
                        style: ElevatedButton.styleFrom(
                          primary: secondary6,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: secondary3,
                            fontWeight: FontWeight.w700,
                            fontFamily: chineseFontfamily,
                          ),
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

  //* 數量
  Column countSlide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "數量",
          style: TextStyle(
            fontFamily: chineseFontfamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: countController,
            maxLines: null,
            keyboardType: defaultTargetPlatform == TargetPlatform.iOS
                ? const TextInputType.numberWithOptions(
                    decimal: true, signed: true)
                : TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: secondary3),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: " Number",
              fillColor: Colors.grey[200],
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Empty!";
              } else if (int.parse(value) <= 0) {
                return "Error Range! Pleace input more than 0";
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  //* 收納地點
  StatefulBuilder placeCard() {
    return StatefulBuilder(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 64,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Card(
                child: InkWell(
                  onTap: () {
                    state(() {
                      storePlace = '冷凍';
                    });
                  },
                  child: ClipPath(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: storePlace == '冷凍' ? primaryColor2 : secondary2,
                        border: const Border(
                          left: BorderSide(color: primaryColor7, width: 5),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.ac_unit_rounded),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '冷凍',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: chineseFontfamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    state(() {
                      storePlace = '冷藏';
                    });
                  },
                  child: ClipPath(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: storePlace == '冷藏' ? primaryColor2 : secondary2,
                        border: const Border(
                          left: BorderSide(color: primaryColor7, width: 5),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.kitchen_rounded),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '冷藏',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: chineseFontfamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    state(() {
                      storePlace = '櫃子';
                    });
                  },
                  child: ClipPath(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: storePlace == '櫃子' ? primaryColor2 : secondary2,
                        border: const Border(
                          left: BorderSide(color: primaryColor7, width: 5),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.all_inbox_rounded),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '櫃子',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: chineseFontfamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* 食物類別下落選單
  StatefulBuilder foodTypeDropdown() {
    return StatefulBuilder(
      builder: (context, state) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor6,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: DropdownButton(
                isExpanded: true,
                value: foodType,
                icon: const Icon(
                  Icons.arrow_circle_down,
                  color: primaryColor8,
                  size: 24,
                ),
                elevation: 16,
                style: const TextStyle(
                  color: primaryColor8,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: englishFontfamily,
                ),
                underline: Container(),
                items: items.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: chineseFontfamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (String? newValue) {
                  state(() {
                    foodType = newValue!;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(
    String title,
    String year,
    String month,
    String day,
    String count,
    String place,
    String foodType,
    String used,
  ) async {
    var _id = M.ObjectId(); // store Unique id inside our variable
    final data = UserMongoDbModel(
      id: _id,
      uid: user.uid,
      title: title,
      year: year,
      month: month,
      day: day,
      count: count,
      place: place,
      foodType: foodType,
      used: used,
    );
    var result = await MongoDatabase.insert(data)
        .whenComplete(() => Navigator.pop(context));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("匯入成功！"),
      ),
    );
    _clearAll();
  }

  void _clearAll() {
    titleController.text = "";
    countController.text = "";
    splaceController.text = "";
  }
}
