import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  DateTime dateNow = DateTime.now();
  DateTime deadline = DateTime.parse("2022-10-11 06:00:00");
  String result = 'No Result yet';

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(result),
            const SizedBox(height: 10),
            Text(dateNow.toString()),
            TextFormField(
              initialValue: deadline.toString(),
              onSaved: (String? fieldValue) {
                deadline = DateTime.parse(fieldValue!);
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _key.currentState!.save();
                setState(() {
                  int days = deadline.difference(dateNow).inDays;
                  int hours = (deadline.difference(dateNow).inHours % 24);
                  int minutes = (deadline.difference(dateNow).inMinutes % 60);

                  result = '剩下 $days Day $hours Hours $minutes Minutes';
                });
              },
              child: const Text('caculate'),
            ),
          ],
        ),
      ),
    );
  }
}
