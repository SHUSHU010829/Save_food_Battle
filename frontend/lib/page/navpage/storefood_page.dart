import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class StorefoodPage extends StatefulWidget {
  const StorefoodPage({Key? key}) : super(key: key);

  @override
  State<StorefoodPage> createState() => _StorefoodPageState();
}

class _StorefoodPageState extends State<StorefoodPage> {
  List<String> items = ['Item1', 'Item2', 'Item3', 'Item4'];
  String? dropdownValue = 'Item1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        //padding: const EdgeInsets.only(left: 32, top: 36, right: 24),
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
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
                padding: const EdgeInsets.only(right: 16.0, top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(child: _dropDown()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: primaryColor1,
        border: Border.all(
          color: primaryColor6,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SizedBox(
          width: 160.0,
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
}
