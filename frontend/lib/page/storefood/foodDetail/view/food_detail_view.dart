// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/storefood_carditem2.dart';
import 'package:frontend/page/storefood/foodDetail/food_detail.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}

class FoodDetailView extends StatelessWidget {
  final AllCardItem all_card_item;

  /// {@macro counter_view}

  const FoodDetailView({
    Key? key,
    required this.all_card_item,
  }) : super(key: key);

  // ignore: todo
  //TODO 把原本頁面跟其合併
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor3,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          //* 食材標頭
          Container(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
            alignment: Alignment.center, // 內裝元件置中對齊
            decoration: const BoxDecoration(
              // 裝飾內裝元件
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24.0),
              ),
              color: primaryColor3, // 綠色背景
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    all_card_item.urlImage,
                    scale: 2.0,
                    fit: BoxFit.cover,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      all_card_item.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: englishFontfamily,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center, // 內裝元件置中對齊
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: secondary3, // 綠色背景
                          ),
                          child: Text(
                            all_card_item.date,
                            style: const TextStyle(
                              color: secondary2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: englishFontfamily,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center, // 內裝元件置中對齊
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: secondary5, // 綠色背景
                          ),
                          child: Row(
                            children: [
                              Text(
                                all_card_item.count.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: englishFontfamily,
                                ),
                              ),
                              Text(
                                all_card_item.unit,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: englishFontfamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center, // 內裝元件置中對齊
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: secondary6, // 綠色背景
                          ),
                          child: Text(
                            all_card_item.place,
                            style: const TextStyle(
                              fontSize: 18,
                              color: primaryColor8,
                              fontWeight: FontWeight.w500,
                              fontFamily: englishFontfamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //* Body
          Container(
            padding: const EdgeInsets.only(left: 32, top: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "剩餘份量",
                      style: TextStyle(
                        fontSize: 22,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Column contents vertically,
                  children: [
                    IconButton(
                      key: const Key(
                          'counterView_decrement_floatingActionButton'),
                      onPressed: () =>
                          context.read<FoodDetailCubit>().decrement(),
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        size: 32,
                        color: primaryColor4,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 5, // Space between underline and text
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.amber,
                            width: 2.0, // Underline thickness
                          ),
                        ),
                      ),
                      child: BlocBuilder<FoodDetailCubit, int>(
                        builder: (context, state) {
                          return Text(
                            '$state',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              fontFamily: englishFontfamily,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      key: const Key(
                          'counterView_increment_floatingActionButton'),
                      onPressed: () =>
                          context.read<FoodDetailCubit>().increment(),
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 32,
                        color: primaryColor4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 392,
                                color: secondary5,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          const Text(
                                            "有效日期",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: chineseFontfamily,
                                              color: textColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.remove_circle_outline,
                                                  size: 32,
                                                  color: primaryColor4,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  bottom:
                                                      5, // Space between underline and text
                                                ),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.amber,
                                                      width:
                                                          2.0, // Underline thickness
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  all_card_item.date,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        englishFontfamily,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.add_circle_outline,
                                                  size: 32,
                                                  color: primaryColor4,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const Text(
                                            "收納地點",
                                            style: TextStyle(
                                              fontSize: 20,
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
                                      ElevatedButton(
                                        child: const Text('Close BottomSheet'),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          "編輯食材",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: chineseFontfamily,
                            color: textColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
