// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:frontend/page/scanpage/edit_food_page.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _currentstep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Expanded(child: QrScanWidget()),
          Theme(
            data: ThemeData(
              // primarySwatch: Colors.orange,
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(227, 181, 135, 1),
              ),
            ),
            child: Stepper(
              currentStep: _currentstep,
              type: StepperType.vertical,
              physics: const ScrollPhysics(),
              onStepTapped: (int Index) {
                setState(() {
                  _currentstep = Index;
                });
              },

              onStepContinue: () {
                //our total index are 3
                if (_currentstep != 2) {
                  setState(() {
                    _currentstep += 1;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditFoodPage(),
                    ),
                  );
                }
              },

              //on cancel btn
              onStepCancel: () {
                if (_currentstep != 0) {
                  setState(() {
                    _currentstep -= 1;
                  });
                }
              },

              steps: <Step>[
                Step(
                  title: const Text('First Scan'),
                  content: Container(
                    width: 200,
                    height: 200,
                    color: Colors.green[300],
                  ),
                  isActive: _currentstep >= 0,
                  state: _currentstep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Second Scan'),
                  content: Container(
                    width: 200,
                    height: 200,
                    color: Colors.green[300],
                  ),
                  isActive: _currentstep >= 0,
                  state: _currentstep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('確認掃描完成！'),
                  content: Column(
                      // children: const [Text("確認掃描完成！")],
                      ),
                  isActive: _currentstep >= 0,
                  state: _currentstep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
