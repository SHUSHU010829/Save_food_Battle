import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/tobuy_model.dart';
import 'package:frontend/widgets/tobuy_item.dart';

class TobuyPage extends StatefulWidget {
  const TobuyPage({Key? key}) : super(key: key);

  @override
  _TobuyPageState createState() => _TobuyPageState();
}

class _TobuyPageState extends State<TobuyPage> {
  List<TobuyModel> tobuys = [];
  TextEditingController tobuyController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor2,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              //NOTE: TITLE
              const Text(
                "Tobuy List",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              //NOTE: Tobuy List
              Expanded(
                  child: Column(
                children: tobuys
                    .map((item) => TobuyItem(
                          title: item.title,
                        ))
                    .toList(),
              )),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  bottom: 50,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: tobuyController,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Add tobuy..."),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(tobuyController.text);
                          setState(() {
                            tobuys.add(TobuyModel(
                                title: tobuyController.text, isDone: false));
                            tobuyController.text = "";
                          });
                        },
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
