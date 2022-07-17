import 'package:flutter/material.dart';

class TobuyItem extends StatefulWidget {
  final String title;
  const TobuyItem({required this.title});

  @override
  _TobuyItemState createState() => _TobuyItemState();
}

class _TobuyItemState extends State<TobuyItem> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDone = !isDone;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: isDone ? const Icon(Icons.check) : const SizedBox(),
        ),
      ),
    );
  }
}
