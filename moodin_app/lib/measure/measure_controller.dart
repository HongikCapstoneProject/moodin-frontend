import 'measure_model.dart';
import 'package:flutter/material.dart';

class MeasureController extends ChangeNotifier {
  final MeasureModel model;

  MeasureController(this.model);

  void setUploadedFileName(String name) {
    model.uploadedFileName = name;
    notifyListeners();
  }

  void startMeasurement() {
    model.isMeasuring = true;
    model.isDone = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: 5), () {
      model.isMeasuring = false;
      model.isDone = true;
      model.hrv = 42; // 예시 측정값
      model.gsr = 61; // 예시 측정값
      notifyListeners();
    });
  }
}
