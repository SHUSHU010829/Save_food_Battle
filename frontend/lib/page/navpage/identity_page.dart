// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

import '../../main.dart';
//import '../../main.dart';

//32圖圖田 import 'package:frontend/page/scanpage/edit_food_page.dart';

//List<CameraDescription>? cameras;
class IdentityPage extends StatefulWidget {
  const IdentityPage({Key? key}) : super(key: key);

  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  bool isWorking = false;
  double? imageHeight;
  double? imageWidth;
  CameraController? cameraController;
  CameraImage? imgCamera;
  List? recognitionsList;

  //init Camera
  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelOnStreamFrame(),
                }
            });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController!.stopImageStream();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState;
    loadModel();
    initCamera();
  }

//runmodel
  runModelOnStreamFrame() async {
    imageHeight = imgCamera!.height + 0.0;
    imageWidth = imgCamera!.width + 0.0;
    recognitionsList = await Tflite.detectObjectOnFrame(
      bytesList: imgCamera!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      /*
      model: 'Test',
      imageHeight: imgCamera!.height,
      imageWidth: imgCamera!.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 5,
      //threshold: 0.1,*/
      model: 'FoodModel',
      imageHeight: imgCamera!.height,
      imageWidth: imgCamera!.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.1,
    );
    isWorking = false;
    setState(() {
      imgCamera;
    });
  }

  //Load tfmoddel
  Future loadModel() async {
    Tflite.close();
    try {
      String response;

      response = (await Tflite.loadModel(
          model: "assets/model/food_model.tflite",
          labels: "assets/model/food_model.txt"))!;
      //model: 'assets/model/Test.tflite',
      //labels: 'assets/model/Test.txt'))!;
      print(response);
      //oh yes !! load model success finally. cry die
    } on PlatformException {
      print('No Model Loading,  go to debug la hahaha :) Unable Unable');
    }
  }

  List<Widget> displayBoxesAroundRecognozedObjects(Size screen) {
    if (recognitionsList == null) return [];
    if (imageHeight == null || imageWidth == null) return [];
    double factorX = screen.width;
    double factorY = imageHeight!;

    Color colorPick = Colors.green;

    return recognitionsList!.map((result) {
      return Positioned(
        left: result["rect"]["x"] * factorX,
        top: result["rect"]["y"] * factorY,
        width: result["rect"]["w"] * factorX,
        height: result["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.green, width: 2.0),
          ),
          child: Text(
            "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildrenWidgets = [];

    stackChildrenWidgets.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height - 100,
        child: Container(
          height: size.height - 100,
          child: (!cameraController!.value.isInitialized)
              ? new Container()
              : AspectRatio(
                  aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(cameraController!),
                ),
        ),
        /*child: Container(
        height: size.height - 100,
        child: (!cameraController!.value.isInitialized)
            ? new Container()
            : AspectRatio(
                aspectRatio: cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController!),
              ),
      ),*/
      ),
    );

    if (imgCamera != null) {
      stackChildrenWidgets.addAll(displayBoxesAroundRecognozedObjects(size));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(top: 50.0),
          color: Colors.black,
          child: Stack(
            children: stackChildrenWidgets,
          ),
        ),
      ),
    );
  }
  /*
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<>('recognitionsList', recognitionsList));
  }*/
}
