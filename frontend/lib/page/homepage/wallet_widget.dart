import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/dbHelper/user/mongodb.dart';
import 'package:frontend/models/dbModel/wallet_model.dart';
import 'package:frontend/theme/constants.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class WalletWidget extends StatefulWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const[
              Text(
                "WALLETS",
                style: TextStyle(
                  fontFamily: englishSpecialFontfamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "\$ ",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  FutureBuilder(
                    future: MongoDatabase().getWalletData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "連接中",
                          style: TextStyle(
                              fontFamily: englishFontfamily,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: textColor2),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return const Text(
                            "Not yet activated",
                            style: TextStyle(
                              fontFamily: englishFontfamily,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        } else {
                          return const Text(
                            "No Data Available",
                            style: TextStyle(
                              fontFamily: englishFontfamily,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text(
                    "代繳：",
                    style: TextStyle(
                      fontFamily: chineseFontfamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "\$",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "0",
                    style: TextStyle(
                      fontFamily: englishFontfamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
