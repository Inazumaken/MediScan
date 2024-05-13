import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mediscantstv2/Bottom_Sheet.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ResultScreen extends StatefulWidget {
  final File imageFile;

  ResultScreen({required this.imageFile});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<dynamic> _outputs = [];
  bool _isBottomSheetOpen = false;

  Future loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    print(res);
  }

  Future _makePrediction() async {
    var recognitions = await Tflite.runModelOnImage(
      path: widget.imageFile.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 5,
      threshold: 0.5,
    );

    setState(() {
      _outputs = recognitions!;
    });
  }

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      _makePrediction();
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetWidget(
            title: _outputs.isNotEmpty ? _outputs[0]["label"] : "",
            onSelected: (String value) {
              if (value == 'Description') {
                // Show description
              } else if (value == 'Usage') {
                // Show usage
              }
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Image.file(widget.imageFile),
            ),
            SizedBox(height: 20),
            _outputs!= null
            ? Column(
                    children: _outputs
                    .map((output) => Column(
                          children: [
                            ListTile(
                              title: Text(
                                '${output["label"]}: ${output["confidence"] * 100}%',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () {
                                  if (!_isBottomSheetOpen) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BottomSheetWidget(
                                          title: output["label"],
                                          onSelected: (String value) {
                                            if (value == 'Description') {
                                              // Show description
                                            } else if (value == 'Usage') {
                                              // Show usage
                                            }
                                          },
                                        );
                                      },
                                    );
                                    setState(() {
                                      _isBottomSheetOpen = true;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ))
                    .toList(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}