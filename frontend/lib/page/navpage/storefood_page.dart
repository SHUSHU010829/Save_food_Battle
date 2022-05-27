import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class StorefoodPage extends StatefulWidget {
  const StorefoodPage({Key? key}) : super(key: key);

  @override
  State<StorefoodPage> createState() => _StorefoodPageState();
}

class _StorefoodPageState extends State<StorefoodPage> {
  List<String> items = ['Place1', 'Place2', 'Place3', 'Place4'];
  String? dropdownValue = 'Place1';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 136,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(48)),
                color: secondary1,
                gradient: LinearGradient(
                  colors: [
                    (Color.fromRGBO(253, 241, 194, 1)),
                    (Color.fromRGBO(253, 241, 194, 1)),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimSearchBar(
                      width: 210,
                      textController: textController,
                      helpText: 'Search...',
                      onSuffixTap: () {
                        setState(() {
                          textController.clear();
                        });
                      },
                    ),
                    Container(child: _dropDown()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 32),
                Text(
                  "即期食品",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 32),
                  buildCard(),
                  const SizedBox(width: 16),
                  buildCard(),
                  const SizedBox(width: 16),
                  buildCard(),
                  const SizedBox(width: 16),
                  buildCard(),
                  const SizedBox(width: 16),
                  buildCard(),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 32),
                Text(
                  "全部食品",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    fontFamily: chineseFontfamily,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        //color: primaryColor1,
        border: Border.all(
          color: primaryColor6,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SizedBox(
          width: 80.0,
          child: DropdownButton(
            isExpanded: true,
            value: dropdownValue,
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
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 100,
          height: 80,
          color: primaryColor2,
          child: Column(
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1587590227264-0ac64ce63ce8?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770',
              ),
              const SizedBox(height: 8),
              const Text(
                'Apple',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: englishFontfamily,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 36.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    color: primaryColor4,
                    child: Row(
                      children: const [
                        SizedBox(width: 4, height: 20),
                        Text(
                          '# 05/20',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: englishFontfamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
